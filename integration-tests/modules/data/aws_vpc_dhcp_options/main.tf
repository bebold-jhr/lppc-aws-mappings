resource "aws_vpc_dhcp_options" "this" {
  domain_name         = "example.com"
  domain_name_servers = ["8.8.8.8", "8.8.4.4"]
}
