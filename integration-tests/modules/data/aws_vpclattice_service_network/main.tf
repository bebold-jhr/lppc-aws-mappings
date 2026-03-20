resource "random_uuid" "this" {}

resource "aws_vpclattice_service_network" "this" {
  name = "lppc-test-${random_uuid.this.result}"
}
