resource "random_uuid7" "this" {}

resource "aws_codebuild_fleet" "this" {
  name             = "lppc-test-${random_uuid7.this.result}"
  base_capacity    = 1
  compute_type     = "BUILD_GENERAL1_SMALL"
  environment_type = "LINUX_CONTAINER"
}
