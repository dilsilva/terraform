#ROLES/POLICIES

#AUTHORIZATED ACCESS ROLE DEFINITION
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

#UNAUTHORIZATED ACCESS ROLE DEFINITION
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
