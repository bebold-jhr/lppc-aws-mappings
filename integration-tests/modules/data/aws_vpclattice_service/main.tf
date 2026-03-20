resource "random_uuid" "this" {}

resource "aws_vpclattice_service" "this" {
  name = "lppc-test-${substr(random_uuid.this.result, 0, 29)}"
}
