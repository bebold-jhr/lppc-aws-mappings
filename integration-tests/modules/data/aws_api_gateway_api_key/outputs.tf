output "api_key" {
  value     = aws_api_gateway_api_key.this
  sensitive = true
}
