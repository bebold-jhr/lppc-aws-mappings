data "aws_api_gateway_export" "this" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
  export_type = "oas30"
}
