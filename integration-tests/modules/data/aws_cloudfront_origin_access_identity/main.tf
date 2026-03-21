resource "random_uuid7" "this" {}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "lppc-test-${random_uuid7.this.result}"
}
