data "aws_ec2_transit_gateway_route_tables" "this" {
  filter {
    name   = "transit-gateway-id"
    values = [var.transit_gateway_id]
  }
}
