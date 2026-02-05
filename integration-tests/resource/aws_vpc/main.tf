resource "aws_vpc" "this" {
  cidr_block         = "10.0.0.0/21"
  enable_dns_support = var.enable_dns_support
  instance_tenancy   = var.instance_tenancy
  tags               = var.tags
}