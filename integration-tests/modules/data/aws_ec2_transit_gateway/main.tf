resource "random_uuid" "name" {}

resource "aws_ec2_transit_gateway" "this" {
  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}
