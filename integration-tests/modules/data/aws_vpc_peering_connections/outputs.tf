output "requester_vpc" {
  value = aws_vpc.requester
}

output "peering_connection" {
  value = aws_vpc_peering_connection.this
}
