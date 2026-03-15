data "aws_ssm_patch_baselines" "this" {
  filter {
    key    = "OWNER"
    values = ["AWS"]
  }
}
