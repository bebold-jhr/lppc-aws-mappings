resource "random_uuid7" "this" {}

resource "aws_api_gateway_rest_api" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "test"
}
