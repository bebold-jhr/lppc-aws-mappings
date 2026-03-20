data "aws_apigatewayv2_export" "this" {
  api_id        = var.api_id
  specification = "OAS30"
  output_type   = "JSON"
}
