# module "elb_http" {
#   source  = "terraform-aws-modules/elb/aws"
#   version = "~> 2.0"

#   name = "elb-juvo"

#   subnets         = module.vpc.public_subnets
#   security_groups = module.vpc.default_security_group_id
#   internal        = false

#   listener = [
#     {
#       instance_port     = "80"
#       instance_protocol = "HTTP"
#       lb_port           = "80"
#       lb_protocol       = "HTTP"
#     },
#     {
#       instance_port     = "8080"
#       instance_protocol = "http"
#       lb_port           = "8080"
#       lb_protocol       = "http"
#       ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
#     },
#   ]

#   health_check = {
#     target              = "HTTP:80/"
#     interval            = 30
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#   }

#   access_logs = {
#     bucket = "juvo-access-logs-bucket"
#   }

#   // ELB attachments
#   number_of_instances = 2
#   instances           = ["i-06ff41a77dfb5349d", "i-4906ff41a77dfb53d"]

#   tags = {
#     Terraform   = "true"
#     Owner       = "Juvo"
#     Environment = "dev"
#   }
# }