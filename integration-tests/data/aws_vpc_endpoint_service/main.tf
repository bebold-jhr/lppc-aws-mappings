data "aws_vpc_endpoint_service" "this" {
  service      = "s3"
  service_type = "Gateway"
}
