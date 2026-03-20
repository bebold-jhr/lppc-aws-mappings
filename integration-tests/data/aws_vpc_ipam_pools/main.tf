data "aws_vpc_ipam_pools" "this" {
  filter {
    name   = "ipam-pool-id"
    values = [var.ipam_pool_id]
  }
}
