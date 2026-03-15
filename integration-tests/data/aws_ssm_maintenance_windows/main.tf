data "aws_ssm_maintenance_windows" "this" {
  filter {
    name   = "Enabled"
    values = ["true"]
  }
}
