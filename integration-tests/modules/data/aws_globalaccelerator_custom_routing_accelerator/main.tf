resource "random_uuid7" "this" {}

resource "aws_globalaccelerator_custom_routing_accelerator" "this" {
  name    = "lppc-test-${random_uuid7.this.result}"
  enabled = false
}
