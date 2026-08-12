data "aws_guardduty_finding_ids" "this" {
  detector_id = var.detector_id
}
