data "aws_route" "this" {
  route_table_id         = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
}
