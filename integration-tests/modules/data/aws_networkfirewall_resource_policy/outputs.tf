output "firewall_policy" {
  value = aws_networkfirewall_firewall_policy.this
}

output "resource_policy" {
  value = aws_networkfirewall_resource_policy.this
}
