resource "random_uuid7" "this" {}

resource "aws_apigatewayv2_api" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  protocol_type = "HTTP"
}
