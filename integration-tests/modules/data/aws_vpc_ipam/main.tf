data "aws_region" "current" {}

resource "aws_vpc_ipam" "this" {
  operating_regions {
    region_name = data.aws_region.current.id
  }
}
