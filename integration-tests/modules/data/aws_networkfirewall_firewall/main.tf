resource "random_uuid7" "this" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_networkfirewall_firewall_policy" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  firewall_policy {
    stateless_default_actions          = ["aws:drop"]
    stateless_fragment_default_actions = ["aws:drop"]
  }
}

resource "aws_networkfirewall_firewall" "this" {
  name                = "lppc-test-${random_uuid7.this.result}"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.this.arn
  vpc_id              = aws_vpc.this.id

  subnet_mapping {
    subnet_id = aws_subnet.this.id
  }
}
