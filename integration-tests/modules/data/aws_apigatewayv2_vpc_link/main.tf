resource "random_uuid7" "this" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_apigatewayv2_vpc_link" "this" {
  name               = "lppc-test-${random_uuid7.this.result}"
  security_group_ids = [aws_security_group.this.id]
  subnet_ids         = [aws_subnet.this.id]
}
