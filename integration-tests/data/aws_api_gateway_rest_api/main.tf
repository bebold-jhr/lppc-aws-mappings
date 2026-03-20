data "aws_api_gateway_rest_api" "this" {
  name = var.rest_api_name
}
