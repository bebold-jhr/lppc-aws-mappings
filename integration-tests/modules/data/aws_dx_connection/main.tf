resource "random_uuid7" "this" {}

data "aws_dx_locations" "this" {}

resource "aws_dx_connection" "this" {
  name      = random_uuid7.this.result
  bandwidth = "1Gbps"
  location  = sort(data.aws_dx_locations.this.location_codes)[0]
}
