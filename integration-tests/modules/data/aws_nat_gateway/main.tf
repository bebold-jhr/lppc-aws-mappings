resource "random_uuid" "name" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_eip" "this" {
  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }

  depends_on = [aws_internet_gateway.this]
}
