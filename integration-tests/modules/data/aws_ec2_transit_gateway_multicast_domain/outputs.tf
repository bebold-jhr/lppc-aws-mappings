output "transit_gateway" {
  value = aws_ec2_transit_gateway.this
}

output "multicast_domain" {
  value = aws_ec2_transit_gateway_multicast_domain.this
}
