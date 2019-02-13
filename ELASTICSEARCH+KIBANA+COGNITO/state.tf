terraform {
  backend "s3" {
    encrypt = true
    bucket = "sap-terraform-state"
    dynamodb_table = "sap-terraform-state-locking"
    key    = "sap-terraform-state/minihub/env:/development/terraform/remote-state"
    region = "us-east-1"
  }

}

data "aws_s3_bucket" "terraform-state-s3" {
  bucket = "sap-terraform-state"

#   versioning {
#       enabled = true
#   }
#   lifecycle {
#       prevent_destroy = true
#   }

}

data "aws_dynamodb_table" "terraform-lock-dynamo" {
  name           = "sap-terraform-state-locking"
#   read_capacity  = 20
#   write_capacity = 20
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#   tags = "${var.tags}"

}

