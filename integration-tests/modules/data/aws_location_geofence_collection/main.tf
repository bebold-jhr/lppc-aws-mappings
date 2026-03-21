resource "random_uuid7" "this" {}

resource "aws_location_geofence_collection" "this" {
  collection_name = "${random_uuid7.this.result}-rg"
}
