#!/bin/bash -x
usermod -a -G docker ec2-user
EC2_INSTANCE_IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
EC2_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
mkdir -p /opt/consul/data
mkdir -p /opt/consul/config
docker run -d --net=host -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 \
  -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp \
  -v /opt/consul/data:/consul/data -v /opt/consul/config:/consul/config \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -h $${EC2_INSTANCE_ID} --name consul-server -e CONSUL_ALLOW_PRIVILEGED_PORTS=1 \
  -l service_name=consul-server consul:1.2.3 agent -server \
  -bootstrap-expect 1 -advertise $${EC2_INSTANCE_IP_ADDRESS} -client 0.0.0.0 -ui
yum install -y aws-cfn-bootstrap
/opt/aws/bin/cfn-signal -e $? --stack $${AWS::StackName} --resource ConsulInstance --region ${AWS_REGION}