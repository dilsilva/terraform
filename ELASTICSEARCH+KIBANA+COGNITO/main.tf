#ELASTICSEARCH DOMAIN DEFINITIONS
resource "aws_elasticsearch_domain" "es-domain" {
  count                 = "${var.enabled == "true" ? 1 : 0}"
  domain_name           = "${var.name}-${var.stage}"
  elasticsearch_version = "${var.elasticsearch_version}"


  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }

  # encrypt_at_rest {
  #   enabled    = "${var.encrypt_at_rest_enabled}"
  #   kms_key_id = "${var.encrypt_at_rest_kms_key_id}"
  # }

  cluster_config {
    instance_count           = "${var.instance_count}"
    instance_type            = "${var.instance_type}"
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_count   = "${var.dedicated_master_count}"
    dedicated_master_type    = "${var.dedicated_master_type}"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  node_to_node_encryption {
    enabled = "${var.node_to_node_encryption_enabled}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_index_enabled }"
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_index_cloudwatch_log_group_arn}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_search_enabled }"
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_search_cloudwatch_log_group_arn}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_application_enabled}"
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_application_cloudwatch_log_group_arn}"
  }

  cognito_options{
    enabled                  = "${var.kibana_authentication_enabled}"
    user_pool_id             = "${aws_cognito_user_pool.pool.id}"
    identity_pool_id         = "${aws_cognito_identity_pool.main.id}"
    role_arn                 = "arn:aws:iam::${var.AWS_ACCOUNT}:role/service-role/CognitoAccessForAmazonES"
  }

  tags = "${var.tags}"
  access_policies ="${data.template_file.espolicy.rendered}"

  depends_on = ["aws_cognito_user_pool_domain.main","aws_cognito_user_pool.pool"]
}
