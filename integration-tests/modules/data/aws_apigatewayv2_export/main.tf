resource "random_uuid7" "this" {}

resource "aws_apigatewayv2_api" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "this" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  integration_method = "GET"
  integration_uri    = "https://example.com"
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /test"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}
