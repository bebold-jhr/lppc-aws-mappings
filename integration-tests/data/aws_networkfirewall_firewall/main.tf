data "aws_networkfirewall_firewall" "this" {
  arn = var.firewall_arn
}
