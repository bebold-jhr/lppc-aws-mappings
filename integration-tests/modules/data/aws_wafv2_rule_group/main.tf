resource "random_uuid7" "this" {}

resource "aws_wafv2_rule_group" "this" {
  name     = random_uuid7.this.result
  scope    = "REGIONAL"
  capacity = 10

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = random_uuid7.this.result
    sampled_requests_enabled   = false
  }
}
