data "aws_api_gateway_authorizers" "this" {
  rest_api_id = var.rest_api_id
}
