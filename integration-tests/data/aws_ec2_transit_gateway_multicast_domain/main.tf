data "aws_ec2_transit_gateway_multicast_domain" "this" {
  transit_gateway_multicast_domain_id = var.multicast_domain_id
}
