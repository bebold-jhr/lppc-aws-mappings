data "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = "REGIONAL"
}
