data "aws_ssm_patch_baseline" "this" {
  owner            = "AWS"
  operating_system = "AMAZON_LINUX_2"
  default_baseline = true
}
