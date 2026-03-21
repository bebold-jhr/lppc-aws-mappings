resource "random_uuid7" "this" {}

resource "aws_cloudfront_connection_group" "this" {
  name    = "lppc-test-${random_uuid7.this.result}"
  enabled = true
}
