data "aws_api_gateway_authorizer" "this" {
  rest_api_id   = var.rest_api_id
  authorizer_id = var.authorizer_id
}
