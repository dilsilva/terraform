data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

// VPC us-east-1
data "aws_vpc" "virginia_default_vpc" {
  tags {
    Name = "ECS-EC2-AAT-VPC"
  }
}

// Search subnet IDS based on default VPC ID described above.
// Filters starting by ECS-EC2-AAT Private* (Name on Console its Tag Name here)
data "aws_subnet_ids" "private_subs" {
  vpc_id = "${data.aws_vpc.virginia_default_vpc.id}"

  tags = {
    Tier = "Private"
  }
}

// Search subnet IDS based on default VPC ID described above.
// Filters starting by ECS-EC2-AAT Private* (Name on Console its Tag Name here)
data "aws_subnet_ids" "public_subs" {
  vpc_id = "${data.aws_vpc.virginia_default_vpc.id}"

  tags = {
    Tier = "Public"
  }
}

# Containers

data "template_file" "consul-agent" {
  template = "${file("containers/consul-agent-tf.json")}"
}

data "template_file" "consul-registrator" {
  template = "${file("containers/consul-registrator-tf.json")}"
}

data "template_file" "linkerd-viz" {
  template = "${file("containers/linkerd-viz-tf.json")}"
}

data "template_file" "linkerd" {
  template = "${file("containers/linkerd-tf.json")}"
}

data "template_file" "hello-world" {
  template = "${file("containers/hello-world-tf.json")}"
}

# User data from AutoScalling

data "template_file" "ecs-instance-setup" {
  template = "${file("files/ecs-instance-setup.sh")}"
  
  vars {
    ECS_CLUSTER_NAME  = "${var.ECS_CLUSTER_NAME}"
    AWS_REGION  = "${var.AWS_REGION}"

  }
}

data "template_file" "consul-server-setup" {
  template = "${file("files/consul-server-setup.sh")}"

  vars {
    AWS_REGION  = "${var.AWS_REGION}"

  }
}
