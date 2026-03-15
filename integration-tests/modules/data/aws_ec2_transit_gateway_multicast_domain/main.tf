resource "random_uuid" "name" {}

resource "aws_ec2_transit_gateway" "this" {
  multicast_support = "enable"

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_ec2_transit_gateway_multicast_domain" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}
