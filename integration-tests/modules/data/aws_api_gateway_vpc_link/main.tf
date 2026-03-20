resource "random_uuid7" "this" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_lb" "this" {
  name               = "lppc-${substr(random_uuid7.this.result, 0, 26)}"
  internal           = true
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id = aws_subnet.this.id
  }
}

resource "aws_api_gateway_vpc_link" "this" {
  name        = "lppc-test-${random_uuid7.this.result}"
  target_arns = [aws_lb.this.arn]
}
