output "App client id" {
  value       = "${aws_cognito_user_pool.pool.id}"
  description = "App client id"
}
output "User Pool Client ID" {
  value       = "${aws_cognito_user_pool_client.client.id}"
  description = "User pool Client ID"
}
output "Domain ID" {
  value       = "${aws_cognito_user_pool_domain.main.id}"
  description = "Domain ID"
}

output "Userpool ID" {
  value       = "${aws_cognito_user_pool.pool.id}"
  description = "Userpool ID"
}

output "Userpool Endpoint" {
  value       = "${aws_cognito_user_pool.pool.endpoint}"
  description = "Userpool ID"
}

output "Kibana Endpoint" {
  value       = "${aws_elasticsearch_domain.es-domain.*.kibana_endpoint}"
  description = "Domain-specific endpoint for Kibana without https scheme"
}

# output "Elasticsearch Endpoint" {
#   value       = "${aws_elasticsearch_domain.es-domain.*.endpoint}"
#   description = "Domain-specific endpoint for Elasticsearch without https scheme"
# }
# output "Elasticsearch ARN" {
#   value       = "${aws_elasticsearch_domain.es-domain.*.id}"
#   description = "Domain-specific endpoint for Elasticsearch without https scheme"
# }