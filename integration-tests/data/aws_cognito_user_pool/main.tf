data "aws_cognito_user_pool" "this" {
  user_pool_id = var.user_pool_id
}
