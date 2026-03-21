resource "random_uuid7" "this" {}

resource "aws_location_place_index" "this" {
  index_name  = "${random_uuid7.this.result}-rg"
  data_source = "Here"
}
