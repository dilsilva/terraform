module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "juvo-cluster"
  instance_count         = 1

  ami                    = "ami-07ebfd5b3428b6f4d"
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = element(module.vpc.private_subnets, 0)

  user_data              = base64encode(local.user_data)

  tags = {
    Terraform   = "true"
    Owner       = "Juvo"
    Environment = "dev"
  
  }

}
