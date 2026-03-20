data "aws_vpc_peering_connection" "this" {
  id = var.peering_connection_id
}
