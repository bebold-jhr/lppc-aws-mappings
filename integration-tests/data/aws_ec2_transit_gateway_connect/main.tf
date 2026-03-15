data "aws_ec2_transit_gateway_connect" "this" {
  transit_gateway_connect_id = var.connect_id
}
