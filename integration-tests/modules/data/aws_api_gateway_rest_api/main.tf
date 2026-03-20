resource "random_uuid7" "this" {}

resource "aws_api_gateway_rest_api" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}
