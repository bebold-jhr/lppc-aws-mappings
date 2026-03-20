resource "random_uuid7" "this" {}

resource "aws_api_gateway_api_key" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}
