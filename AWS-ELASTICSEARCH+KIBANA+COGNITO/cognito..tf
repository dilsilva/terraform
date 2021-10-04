#IDENTITY POOL DEFINITIONS
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

#USER POOL DEFINITIONS
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

