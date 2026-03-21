resource "random_uuid7" "this" {}

resource "aws_location_route_calculator" "this" {
  calculator_name = "${random_uuid7.this.result}-rg"
  data_source     = "Here"
}
