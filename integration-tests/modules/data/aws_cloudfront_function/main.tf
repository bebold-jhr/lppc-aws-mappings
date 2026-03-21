resource "random_uuid7" "this" {}

resource "aws_cloudfront_function" "this" {
  name    = "lppc-test-${replace(random_uuid7.this.result, "-", "")}"
  runtime = "cloudfront-js-2.0"
  code    = "function handler(event) { return event.request; }"
  publish = true
}
