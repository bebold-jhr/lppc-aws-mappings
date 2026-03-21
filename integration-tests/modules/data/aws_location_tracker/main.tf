resource "random_uuid7" "this" {}

resource "aws_location_tracker" "this" {
  tracker_name = "${random_uuid7.this.result}-rg"
}
