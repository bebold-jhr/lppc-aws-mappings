data "aws_ec2_transit_gateway_route_table_routes" "this" {
  transit_gateway_route_table_id = var.transit_gateway_route_table_id

  filter {
    name   = "state"
    values = ["active"]
  }
}
