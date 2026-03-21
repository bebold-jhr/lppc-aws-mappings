data "aws_location_tracker_association" "this" {
  tracker_name = var.tracker_name
  consumer_arn = var.consumer_arn
}
