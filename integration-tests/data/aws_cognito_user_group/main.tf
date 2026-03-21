data "aws_cognito_user_group" "this" {
  user_pool_id = var.user_pool_id
  name         = var.name
}
