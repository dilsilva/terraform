variable "SKEY" {
    type        = "string"
    description = "Secret Key"
}

variable "AKEY" {
  type        = "string"
  description = "Access Key"
}

variable "AWS_REGION" {
  type        = "string"
  description = "Region of the deployment"
}

variable "AWS_ACCOUNT" {
  type        = "string"
  description = "Account of the deployment"
}

## ELASTICSEARCH

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  description = "Name of the application"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "enabled" {
  type        = "string"
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "elasticsearch_version" {
  type        = "string"
  default     = "6.2"
  description = "Version of Elasticsearch to deploy"
}

variable "instance_type" {
  type        = "string"
  default     = "t2.small.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster"
  default     = 4
}

variable "iam_role_arns" {
  type        = "list"
  default     = []
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "iam_actions" {
  type        = "list"
  default     = []
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "zone_awareness_enabled" {
  type        = "string"
  default     = "true"
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "ebs_volume_size" {
  description = "Optionally use EBS volumes for data storage by specifying volume size in GB"
  default     = 0
}

variable "ebs_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "ebs_iops" {
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "encrypt_at_rest_enabled" {
  type        = "string"
  default     = "true"
  description = "Whether to enable encryption at rest"
}

# variable "encrypt_at_rest_kms_key_id" {
#   type        = "string"
#   default     = "false" 
#   description = "The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
# }

variable "log_publishing_index_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
}

variable "log_publishing_search_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
}

variable "log_publishing_application_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
}

variable "log_publishing_index_cloudwatch_log_group_arn" {
  type        = "string"
  default     = ""
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  type        = "string"
  default     = ""
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS  needs to be published"
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  type        = "string"
  default     = ""
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
}

variable "automated_snapshot_start_hour" {
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}

variable "dedicated_master_enabled" {
  type        = "string"
  default     = "false"
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  type        = "string"
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "advanced_options" {
  type        = "map"
  default     = {}
  description = "Key-value string pairs to specify advanced configuration options"
}

variable "kibana_subdomain_name" {
  type        = "string"
  default     = "kibana"
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
}

variable "create_iam_service_linked_role" {
  type        = "string"
  default     = "true"
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}

variable "node_to_node_encryption_enabled" {
  type        = "string"
  default     = "false"
  description = "Whether to enable node-to-node encryption"
}

variable "kibana_authentication_enabled" {
  type        = "string"
  default     = "true"
  description = "Specifies whether Amazon Cognito authentication with Kibana is enabled or not"
}

variable "access_ips" {
  type        = "list"
  default     = []
  description = "List of ips that are allowed to access the service"
}