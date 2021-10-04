module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-juvo"

  subnets         = module.vpc.public_subnets
  security_groups = list(aws_security_group.elb_sg.id, module.vpc.default_security_group_id)
  internal        = false

  listener = [
    {
      instance_port     = "8080"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:8080/"
    interval            = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
  }

  // ELB attachments
  number_of_instances = 1
  instances           = [element(module.ec2_cluster.id,0)]

  tags = {
    Terraform   = "true"
    Owner       = "Juvo"
    Environment = "dev"
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Allow TCP traffic for ELB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}