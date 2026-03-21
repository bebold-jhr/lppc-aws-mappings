data "aws_wafv2_regex_pattern_set" "this" {
  name  = var.name
  scope = "REGIONAL"
}
