data "aws_lb_trust_store" "this" {
  arn = var.trust_store_arn
}
