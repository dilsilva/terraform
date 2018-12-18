# Launch Configuration ECS
resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                 = "${var.NAME}-cluster-launch-configuration"
  image_id             = "ami-045f1b3f87ed83659"
  instance_type        = "t2.large"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 30
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = ["${aws_security_group.sg-firewall.id}"]
  associate_public_ip_address = "true"
  key_name                    = "${var.ECS_KEYPAIR_NAME}"
  user_data                   = "${data.template_file.ecs-instance-setup.rendered}"
}

# Autoscalling ECS
resource "aws_autoscaling_group" "ec2-autoscaling-group" {
  name                 = "${var.NAME}-ecs-autoscaling-group"
  max_size             = "${var.MAX_INSTANCE_SIZE}"
  min_size             = "${var.MIN_INSTANCE_SIZE}"
  desired_capacity     = "${var.DESIRED_CAPACITY}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.public_subs.ids}"]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.PREFIX}-${var.NAME}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.ENVRIOMENT}"
    propagate_at_launch = true
  }
}


# Launch Configuration EC2
resource "aws_launch_configuration" "ec2-launch-configuration" {
  name                 = "${var.NAME}-instance-launch-configuration"
  image_id             = "ami-045f1b3f87ed83659"
  instance_type        = "t2.large"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 30
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = ["${aws_security_group.sg-firewall.id}"]
  associate_public_ip_address = "true"
  key_name                    = "${var.ECS_KEYPAIR_NAME}"
  user_data                   = "${data.template_file.consul-server-setup.rendered}"
}

# Autoscalling EC2
resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name                 = "${var.NAME}-consul-autoscaling-group"
  max_size             = "${var.MAX_INSTANCE_SIZE_CONSUL}"
  min_size             = "${var.MIN_INSTANCE_SIZE_CONSUL}"
  desired_capacity     = "${var.DESIRED_CAPACITY_CONSUL}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.public_subs.ids}"]
  launch_configuration = "${aws_launch_configuration.ec2-launch-configuration.name}"
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "consul-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.ENVRIOMENT}"
    propagate_at_launch = true
  }
}
