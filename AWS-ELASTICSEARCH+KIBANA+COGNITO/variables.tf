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
