#!/bin/bash -x
echo ECS_CLUSTER=${ECS_CLUSTER_NAME} >> /etc/ecs/ecs.config
# The following literal block is a script which runs on
# each EC2 instance in the autoscaling group on boot to
# setup up configuration files that are later mounted into
# Linkerd containers for the Linkerd ingress

########################################################################################
#            Always remember to:
#   1 - Set the correct cluster name on first line (same as the terraformed cluster)
#   
#
#
########################################################################################



yum install -y aws-cfn-bootstrap
/opt/aws/bin/cfn-signal -e $? --stack $${AWS::StackName} --resource ECSAutoScalingGroup --region ${AWS_REGION}
- |
#
# This script generates config to be used by their respective Task Definitions:
# 1. consul-registrator startup script
# 2. Consul Agent config
# 3. linkerd config
usermod -a -G docker ec2-user

# Install the AWS CLI and the jq JSON parser
yum install -y aws-cli jq

# Gather metadata for linkerd and Consul Agent
EC2_INSTANCE_IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
EC2_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
#
# Generate consul-registrator startup file
#
mkdir -p /opt/consul-registrator/bin
cat << EOF > /opt/consul-registrator/bin/start.sh
#!/bin/sh
exec /bin/registrator -ip $${EC2_INSTANCE_IP_ADDRESS} -retry-attempts -1 consul://$${EC2_INSTANCE_IP_ADDRESS}:8500
EOF

chmod a+x /opt/consul-registrator/bin/start.sh
#
# Generate Consul Agent config file
#
mkdir -p /opt/consul/data
mkdir -p /opt/consul/config

cat << EOF > /opt/consul/config/consul-agent.json
{
    "advertise_addr": "$${EC2_INSTANCE_IP_ADDRESS}",
    "client_addr": "0.0.0.0",
    "node_name": "$${EC2_INSTANCE_ID}",
    "retry_join": [
        "provider=aws tag_key=Name tag_value=consul-server"
    ]
}
EOF
#
# Generate linkerd config file
#
# The linkerd ECS task definition is configured to mount this config file into
# its own Docker environment.
mkdir -p /etc/linkerd
cat << EOF > /etc/linkerd/linkerd.yaml
admin:
  ip: 0.0.0.0
  port: 9990
namers:
- kind: io.l5d.consul
  host: $${EC2_INSTANCE_IP_ADDRESS}
  port: 8500
telemetry:
- kind: io.l5d.prometheus
- kind: io.l5d.recentRequests
  sampleRate: 0.25
usage:
  orgId: linkerd-examples-ecs
routers:
- protocol: http
  label: outgoing
  servers:
  - ip: 0.0.0.0
    port: 4140
  interpreter:
    kind: default
    transformers:
    # tranform all outgoing requests to deliver to incoming linkerd port 4141
    - kind: io.l5d.port
      port: 4141
  dtab: |
    /svc => /#/io.l5d.consul/dc1;
- protocol: http
  label: incoming
  servers:
  - ip: 0.0.0.0
    port: 4141
  interpreter:
    kind: default
    transformers:
    # filter instances to only include those on this host
    - kind: io.l5d.specificHost
      host: $${EC2_INSTANCE_IP_ADDRESS}
  dtab: |
    /svc => /#/io.l5d.consul/dc1;
EOF