resource "aws_customer_gateway" "this" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"
}
