// VPC
data "aws_vpc" "default_vpc" {
  tags {
    Name = "ECS-EC2-AAT-VPC"
  }
}

// Search subnet IDS based on default VPC ID described above.
// Filters starting by ECS-EC2-AAT Private* (Name on Console its Tag Name here)
data "aws_subnet_ids" "private_subs" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"

  tags = {
    Tier = "Private"
  }
}

// Search subnet IDS based on default VPC ID described above.
// Filters starting by ECS-EC2-AAT Private* (Name on Console its Tag Name here)
data "aws_subnet_ids" "public_subs" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"

  tags = {
    Tier = "Public"
  }
}

# PROVIDER

data "aws_caller_identity" "current" {}


#TEMPLATES DATA

data "template_file" "espolicy" {
  template = "${file("policies/esPolicy.json")}"
  vars = {
    account = "${var.AWS_ACCOUNT}",
    nameenv = "${var.name}-${var.stage}",
    region = "${var.AWS_REGION}"
  }
}
data "template_file" "authrole" {
  template = "${file("policies/AuthRole.json")}"
}
data "template_file" "unauthrole" {
  template = "${file("policies/UnauthRole.json")}"
}
data "template_file" "esauthpermission" {
  template = "${file("policies/ESAuthPermission.json")}"
  vars = {
    account = "${var.AWS_ACCOUNT}",
    nameenv = "${var.name}-${var.stage}",
    region = "${var.AWS_REGION}"
  }
}

data "template_file" "unauthtp" {
  template = "${file("policies/UnauthTrustPolicy.json")}"
  vars = {
    cognito-identity = "${aws_cognito_identity_pool.main.id}"
  }
}

data "template_file" "authtp" {
  template = "${file("policies/AuthTrustPolicy.json")}"
  vars = {
    cognito-identity = "${aws_cognito_identity_pool.main.id}"
  }
}

