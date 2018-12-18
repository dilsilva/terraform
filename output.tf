# output private_subnet_ids {
#   value = "${list(data.aws_subnet_ids.public_subs.ids)}"
# }

# output "Consul Server" {
#   value = "[${element(data.aws_autoscaling_group.example_ips.private_ips, count.index)}:8500]"
# }

output "Linkerd Server" {
  value = "${aws_lb.load_balancer.dns_name}"
}

# output "Grafana Dashboard" {
#   value = "[${element(data.aws_autoscaling_group.example_ips.private_ips, count.index)}:3000]"
# }

