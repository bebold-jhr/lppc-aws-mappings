data "aws_wafv2_managed_rule_group" "this" {
  name        = "AWSManagedRulesCommonRuleSet"
  scope       = "REGIONAL"
  vendor_name = "AWS"
}
