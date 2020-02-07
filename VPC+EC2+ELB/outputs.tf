output "private_subs" {
  value = module.vpc.private_subnets
}

output "public_subs" {
  value = module.vpc.public_subnets
}

output "this_elb_dns_name" {
  value = module.elb_http.this_elb_dns_name
}

output "this_elb_instances" {
  value = module.elb_http.this_elb_instances
}

output "instance_id" {
  value = module.ec2_cluster.id
}

output "instance_key_name" {
  value = module.ec2_cluster.key_name
}

output "instance_public_ip" {
  value = module.ec2_cluster.public_ip
}

output "instance_subnet_id" {
  value = module.ec2_cluster.subnet_id
}


output "VPC_ID" {
  value = module.vpc.vpc_id
}