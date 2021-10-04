# ##########################
# ### GENERAL  VARIABLES ###
# ##########################


# Project & General Configs

variable "gcp_project_id" {
  type        = string
  description = "GCP project id that will be used"
  default     = "track-insight-acc" 
}

variable "gcp_project_name" {
  type        = string
  description = "GCP project name that will be used"
  default     = "track-insight"
}

variable "env" {
  type        = string
  default     = "acc"
  description = "Type of environment [dev or prod]"
}

variable "region" {
  type        = string
  description = "GCP region, e.g. southamerica-east1"
  default     = "europe-west4"
}

variable "zone" {
  type        = string
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default     = "europe-west4-c"
}

variable "zones" {
  type        = list(string)
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default = [
    "europe-west4-c",
  ]
}

variable "subnetwork" {
  default = "default"
}

variable "gcp_credentials_json" {
  type        = string
  description = "File for access to GCP Project"
  default     = ""
}

## -> GCP APIs to enable services.
### Ref. https://github.com/terraform-google-modules/terraform-google-sql-db#enable-apis

locals {
  apis_gcp = toset([
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "vpcaccess.googleapis.com",
    "dns.googleapis.com"
  ])
}

## Load balancer variables
## Docs https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/latest
##

variable "service_port_name" {
  type        = string
  description = "Backend service port name for identification in GCP Load balancer"
  default     = "app"
}

variable "service_port" {
  type        = number
  description = "Backend service port number for identification in GCP Load balancer"
  default     = 80
}

#######################################
#### Cronjob compute instance

variable "cron_machine_type" {
  type        = string
  description = "Compute instance type to be used by cron."
  default     = "n1-standard-2"
}

variable "cron_image" {
  type = string
  description = "Compute instance image name"
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

#######################################
#### Cronjob compute instance

variable "web_machine_type" {
  type        = string
  description = "Compute instance type to be used by cron."
  default     = "n1-standard-2"
}

variable "web_image" {
  type = string
  description = "Compute instance image name"
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

#######################################
#### Memcached variables

variable "cpu_count" {
  description = "Number of CPUs per node"
  default = 1
}
variable "memory_size_mb" {
  description = "Memcache memory size in MiB. Defaulted to 1024"
  default = 1
}
variable "node_count" {
  description = "Number of nodes in the memcache instance."
  default = 1
}
