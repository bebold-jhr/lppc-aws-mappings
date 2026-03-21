data "aws_cloudfront_origin_access_identity" "this" {
  id = var.id
}
