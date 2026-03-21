resource "random_uuid7" "this" {}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "lppc-test-${random_uuid7.this.result}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
