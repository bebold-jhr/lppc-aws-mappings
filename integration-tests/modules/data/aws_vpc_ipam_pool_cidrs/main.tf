data "aws_region" "current" {}

resource "aws_vpc_ipam" "this" {
  operating_regions {
    region_name = data.aws_region.current.id
  }
}

resource "aws_vpc_ipam_pool" "this" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.this.private_default_scope_id
  locale         = data.aws_region.current.id
}

resource "aws_vpc_ipam_pool_cidr" "this" {
  ipam_pool_id = aws_vpc_ipam_pool.this.id
  cidr         = "10.0.0.0/16"
}
