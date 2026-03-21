resource "random_uuid7" "this" {}

resource "aws_dx_gateway" "this" {
  name            = random_uuid7.this.result
  amazon_side_asn = "64512"
}
