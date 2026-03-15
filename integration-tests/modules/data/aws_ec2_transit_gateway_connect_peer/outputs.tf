output "transit_gateway" {
  value = aws_ec2_transit_gateway.this
}

output "connect" {
  value = aws_ec2_transit_gateway_connect.this
}

output "connect_peer" {
  value = aws_ec2_transit_gateway_connect_peer.this
}
