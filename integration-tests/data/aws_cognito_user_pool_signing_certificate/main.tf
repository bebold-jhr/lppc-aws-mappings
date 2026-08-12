data "aws_cognito_user_pool_signing_certificate" "this" {
  user_pool_id = var.user_pool_id
}
