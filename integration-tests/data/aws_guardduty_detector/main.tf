data "aws_guardduty_detector" "this" {
  id = var.detector_id
}
