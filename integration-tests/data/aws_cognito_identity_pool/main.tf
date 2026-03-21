data "aws_cognito_identity_pool" "this" {
  identity_pool_name = var.identity_pool_name
}
