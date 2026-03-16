data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_uuid" "name" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_ec2_transit_gateway" "this" {
  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = [aws_subnet.this.id]
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = aws_vpc.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}
