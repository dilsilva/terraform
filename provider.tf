provider "aws" {
  access_key = "${var.AKEY}"
  secret_key = "${var.SKEY}"
  region     = "${var.AWS_REGION}"
}

