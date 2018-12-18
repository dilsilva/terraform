terraform {
  backend "s3" {
    bucket         = "sap-terraform-state"
    key            = "terraform/remote-state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sap-terraform-state-locking"
  }
}


