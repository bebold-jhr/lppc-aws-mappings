resource "random_uuid7" "this" {}

resource "aws_wafv2_ip_set" "this" {
  name               = random_uuid7.this.result
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["1.2.3.4/32"]
}
