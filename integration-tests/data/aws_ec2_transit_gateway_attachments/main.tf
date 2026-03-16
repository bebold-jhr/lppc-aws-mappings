data "aws_ec2_transit_gateway_attachments" "this" {
  filter {
    name   = "transit-gateway-id"
    values = [var.transit_gateway_id]
  }
}
