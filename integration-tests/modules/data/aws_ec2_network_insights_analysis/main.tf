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

resource "aws_network_interface" "source" {
  subnet_id = aws_subnet.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}-src"
  }
}

resource "aws_network_interface" "destination" {
  subnet_id = aws_subnet.this.id

  tags = {
    Name = "lppc-${random_uuid.name.result}-dst"
  }
}

resource "aws_ec2_network_insights_path" "this" {
  source      = aws_network_interface.source.id
  destination = aws_network_interface.destination.id
  protocol    = "tcp"

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}

resource "aws_ec2_network_insights_analysis" "this" {
  network_insights_path_id = aws_ec2_network_insights_path.this.id
  wait_for_completion      = true

  tags = {
    Name = "lppc-${random_uuid.name.result}"
  }
}
