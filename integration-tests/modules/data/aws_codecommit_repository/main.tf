resource "random_uuid7" "this" {}

resource "aws_codecommit_repository" "this" {
  repository_name = "lppc-test-${random_uuid7.this.result}"
}
