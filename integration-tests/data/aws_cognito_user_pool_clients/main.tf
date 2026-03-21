data "aws_cognito_user_pool_clients" "this" {
  user_pool_id = var.user_pool_id
}
