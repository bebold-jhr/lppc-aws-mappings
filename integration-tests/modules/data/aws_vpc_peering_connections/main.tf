resource "aws_vpc" "requester" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "accepter" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = aws_vpc.requester.id
  peer_vpc_id = aws_vpc.accepter.id
  auto_accept = true
}
