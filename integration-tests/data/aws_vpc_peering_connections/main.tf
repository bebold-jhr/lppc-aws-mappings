data "aws_vpc_peering_connections" "this" {
  filter {
    name   = "requester-vpc-info.vpc-id"
    values = [var.requester_vpc_id]
  }
}
