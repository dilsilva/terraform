# ECS Cluster
resource "aws_ecs_cluster" "sap-cluster" {
  name = "${var.ECS_CLUSTER_NAME}"
}

# ECR Repository
resource "aws_ecr_repository" "staging_ecr" {
  name = "sap-${var.NAME}"
}
resource "aws_ecr_repository" "simpleapp" {
  name = "sap-${var.NAME}"
}

# Services
resource "aws_ecs_service" "sap_linkerd_service" {
  name    = "${var.PREFIX}-linkerd-service"
  scheduling_strategy = "DAEMON"
  cluster = "${aws_ecs_cluster.sap-cluster.id}"

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.linkerd.family}:${max("${aws_ecs_task_definition.linkerd.revision}", "${aws_ecs_task_definition.linkerd.revision}")}"
  desired_count   = 1

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    container_port   = 9990
    container_name   = "linkerd-container"
  }

}

resource "aws_ecs_service" "sap_consul_agent_service" {
  name    = "${var.PREFIX}-consul-agent-service"
  scheduling_strategy = "DAEMON"
  cluster = "${aws_ecs_cluster.sap-cluster.id}"

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.consul-agent.family}:${max("${aws_ecs_task_definition.consul-agent.revision}", "${aws_ecs_task_definition.consul-agent.revision}")}"
  desired_count   = 1

}

resource "aws_ecs_service" "sap_consul_registrator_service" {
  name    = "${var.PREFIX}-consul-registrator-service"
  scheduling_strategy = "DAEMON"
  cluster = "${aws_ecs_cluster.sap-cluster.id}"

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.consul-registrator.family}:${max("${aws_ecs_task_definition.consul-registrator.revision}", "${aws_ecs_task_definition.consul-registrator.revision}")}"
  desired_count   = 1

}

/* Task definitions */
resource "aws_ecs_task_definition" "consul-agent" {
  family                = "consul-agent-tf"
  task_role_arn = "${aws_iam_role.consul-agent-role.arn}"
  container_definitions = "${file("containers/consul-agent-tf.json")}"

  volume {
    name      = "consul-config"
    host_path = "/opt/consul/config"
  }

  volume {
    name      = "consul-data"
    host_path = "/opt/consul/data"
  }

  volume {
    name      = "consul-docker"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_task_definition" "consul-registrator" {
  family                = "consul-registrator-tf"
  container_definitions = "${file("containers/consul-registrator-tf.json")}"

  volume {
    name      = "consul-registrator-bin"
    host_path = "/opt/consul-registrator/bin"
  }

  volume {
    name      = "consul-registrator-docker"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_task_definition" "hello-world" {
  family                = "hello-world-tf"
  container_definitions = "${file("containers/hello-world-tf.json")}"
}
resource "aws_ecs_task_definition" "simpleapp" {
  family                = "simpleapp-tf"
  container_definitions = "${file("containers/simpleapp.json")}"
}

resource "aws_ecs_task_definition" "linkerd-viz" {
  family                = "linkerd-viz-tf"
  container_definitions = "${file("containers/linkerd-viz-tf.json")}"
}

resource "aws_ecs_task_definition" "linkerd" {
  family                = "linkerd-tf"
  container_definitions = "${file("containers/linkerd-tf.json")}"

  volume {
    name      = "linkerd-config"
    host_path = "/etc/linkerd"
  }
}

# Containers details are avaliable in data.tf

