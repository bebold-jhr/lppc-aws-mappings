data "aws_vpc_dhcp_options" "this" {
  dhcp_options_id = var.dhcp_options_id
}
