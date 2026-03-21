resource "random_uuid7" "this" {}

resource "aws_networkfirewall_firewall_policy" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  firewall_policy {
    stateless_default_actions          = ["aws:drop"]
    stateless_fragment_default_actions = ["aws:drop"]
  }
}
