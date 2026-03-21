resource "random_uuid" "this" {}

resource "aws_cognito_user_pool" "this" {
  name = random_uuid.this.result
}
