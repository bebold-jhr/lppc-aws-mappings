data "aws_vpc_ipam_pool_cidrs" "this" {
  ipam_pool_id = var.ipam_pool_id
}
