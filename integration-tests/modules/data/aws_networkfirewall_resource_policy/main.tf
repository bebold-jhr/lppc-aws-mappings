resource "random_uuid7" "this" {}

data "aws_caller_identity" "this" {}

resource "aws_networkfirewall_firewall_policy" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  firewall_policy {
    stateless_default_actions          = ["aws:drop"]
    stateless_fragment_default_actions = ["aws:drop"]
  }
}

resource "aws_networkfirewall_resource_policy" "this" {
  resource_arn = aws_networkfirewall_firewall_policy.this.arn
  policy = jsonencode({
    Statement = [{
      Action   = "network-firewall:ListFirewallPolicies"
      Effect   = "Allow"
      Resource = aws_networkfirewall_firewall_policy.this.arn
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
      }
    }]
    Version = "2012-10-17"
  })
}
