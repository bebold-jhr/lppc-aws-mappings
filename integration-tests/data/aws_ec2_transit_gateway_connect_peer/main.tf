data "aws_ec2_transit_gateway_connect_peer" "this" {
  transit_gateway_connect_peer_id = var.connect_peer_id
}
