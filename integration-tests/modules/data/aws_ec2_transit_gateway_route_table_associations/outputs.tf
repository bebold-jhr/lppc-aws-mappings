output "transit_gateway" {
  value = aws_ec2_transit_gateway.this
}

output "vpc_attachment" {
  value = aws_ec2_transit_gateway_vpc_attachment.this
}

output "vpc_id" {
  value = aws_vpc.this.id
}
