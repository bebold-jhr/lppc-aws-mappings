data "aws_api_gateway_sdk" "this" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
  sdk_type    = "javascript"
}
