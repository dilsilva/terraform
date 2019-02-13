#IDENTITY POOL
resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.name} ${var.stage} identity pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = "${aws_cognito_user_pool_client.client.id}"
    provider_name           = "${aws_cognito_user_pool.pool.endpoint}"
    server_side_token_check = true
  }

  depends_on = ["aws_cognito_user_pool.pool"]
}


resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = "${aws_cognito_identity_pool.main.id}"

  roles = {
    "authenticated" = "${aws_iam_role.authenticated.arn}"
    "unauthenticated" = "${aws_iam_role.unauthenticated.arn}"
  }
  depends_on = ["aws_cognito_identity_pool.main"]
}

#USER POOL
resource "aws_cognito_user_pool" "pool" {
  name = "${var.name}-${var.stage}-userpool"
  tags = "${var.tags}"

}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"
  user_pool_id = "${aws_cognito_user_pool.pool.id}"

  depends_on = ["aws_cognito_user_pool.pool"]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.name}-${var.stage}"
  user_pool_id = "${aws_cognito_user_pool.pool.id}"

  depends_on = ["aws_cognito_user_pool.pool"]
}





#ROLES/POLICIES

#AUTH
resource "aws_iam_role" "authenticated" {
  name = "${var.name}${var.stage}AuthRole"
  assume_role_policy = "${data.template_file.authtp.rendered}"

}
resource "aws_iam_policy" "esauth-policies" {
  name        = "ES${var.name}${var.stage}Auth"
  description = "Policies reffering to ES Auth Role"

  policy = "${data.template_file.esauthpermission.rendered}"
}

resource "aws_iam_policy" "auth-policies" {
  name        = "${var.name}${var.stage}Auth"
  description = "Policies reffering to Cognito Auth Role"

  policy = "${data.template_file.authrole.rendered}"
}

resource "aws_iam_role_policy_attachment" "esauth-attach" {
  role       = "${aws_iam_role.authenticated.name}"
  policy_arn = "${aws_iam_policy.esauth-policies.arn}"
}

resource "aws_iam_role_policy_attachment" "auth-attach" {
  role       = "${aws_iam_role.authenticated.name}"
  policy_arn = "${aws_iam_policy.auth-policies.arn}"
}

#UNAUTH
resource "aws_iam_role" "unauthenticated" {
  name = "${var.name}${var.stage}UnauthRole"  
  assume_role_policy = "${data.template_file.unauthtp.rendered}"

}
resource "aws_iam_policy" "unauth-policies" {
  name        = "${var.name}${var.stage}Unauth"
  description = "Policies reffering to Cognito Unauth Role"

  policy = "${data.template_file.authrole.rendered}"
}
resource "aws_iam_role_policy_attachment" "unauth-attach" {
  role       = "${aws_iam_role.unauthenticated.name}"
  policy_arn = "${aws_iam_policy.unauth-policies.arn}"
}
