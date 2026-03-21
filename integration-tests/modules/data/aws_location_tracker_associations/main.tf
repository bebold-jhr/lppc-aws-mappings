resource "random_uuid7" "this" {}

resource "aws_location_tracker" "this" {
  tracker_name = "${random_uuid7.this.result}-rg"
}

resource "aws_location_geofence_collection" "this" {
  collection_name = "${random_uuid7.this.result}-rg"
}

resource "aws_location_tracker_association" "this" {
  tracker_name = aws_location_tracker.this.tracker_name
  consumer_arn = aws_location_geofence_collection.this.collection_arn
}
