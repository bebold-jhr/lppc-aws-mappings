data "aws_ec2_transit_gateway_route_table" "this" {
  id = var.transit_gateway_route_table_id
}
