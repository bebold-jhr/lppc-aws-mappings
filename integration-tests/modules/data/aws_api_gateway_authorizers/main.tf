resource "random_uuid7" "this" {}

resource "aws_api_gateway_rest_api" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_cognito_user_pool" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_api_gateway_authorizer" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  rest_api_id   = aws_api_gateway_rest_api.this.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.this.arn]
}
