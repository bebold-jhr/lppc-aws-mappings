data "aws_networkfirewall_firewall_policy" "this" {
  arn = var.firewall_policy_arn
}
