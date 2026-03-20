resource "random_uuid7" "this" {}

resource "aws_backup_vault" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_backup_plan" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  rule {
    rule_name         = "lppc-test-rule"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 12 * * ? *)"
  }
}
