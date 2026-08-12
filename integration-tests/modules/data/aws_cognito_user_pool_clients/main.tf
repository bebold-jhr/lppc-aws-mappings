resource "random_uuid" "this" {}

resource "aws_cognito_user_pool" "this" {
  name = random_uuid.this.result
}

resource "aws_cognito_user_pool_client" "this" {
  name         = random_uuid.this.result
  user_pool_id = aws_cognito_user_pool.this.id
}
