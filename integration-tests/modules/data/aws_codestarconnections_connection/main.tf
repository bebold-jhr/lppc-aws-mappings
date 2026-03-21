resource "random_uuid7" "this" {}

resource "aws_codestarconnections_connection" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  provider_type = "GitHub"
}
