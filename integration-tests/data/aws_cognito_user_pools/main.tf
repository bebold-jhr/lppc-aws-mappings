data "aws_cognito_user_pools" "this" {
  name = var.name
}
