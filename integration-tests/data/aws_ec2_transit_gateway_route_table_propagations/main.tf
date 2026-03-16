data "aws_ec2_transit_gateway_route_table_propagations" "this" {
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}
