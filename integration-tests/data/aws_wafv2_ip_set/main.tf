data "aws_wafv2_ip_set" "this" {
  name  = var.name
  scope = "REGIONAL"
}
