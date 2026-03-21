resource "random_uuid7" "this" {}

resource "aws_wafv2_web_acl" "this" {
  name  = random_uuid7.this.result
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = random_uuid7.this.result
    sampled_requests_enabled   = false
  }
}
