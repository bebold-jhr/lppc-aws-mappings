resource "aws_vpn_gateway" "this" {}

resource "aws_customer_gateway" "this" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "this" {
  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this.id
  type                = "ipsec.1"
  static_routes_only  = true
}
