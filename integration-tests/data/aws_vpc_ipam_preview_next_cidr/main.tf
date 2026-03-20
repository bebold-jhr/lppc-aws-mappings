data "aws_vpc_ipam_preview_next_cidr" "this" {
  ipam_pool_id   = var.ipam_pool_id
  netmask_length = 24
}
