data "aws_cognito_user_groups" "this" {
  user_pool_id = var.user_pool_id
}
