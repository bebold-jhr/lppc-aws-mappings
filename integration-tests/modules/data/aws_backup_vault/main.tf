resource "random_uuid7" "this" {}

resource "aws_backup_vault" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}
