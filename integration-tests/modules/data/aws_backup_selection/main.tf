resource "random_uuid7" "this" {}

data "aws_caller_identity" "this" {}

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

resource "aws_iam_role" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
  path = "/lppc/integration-tests/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_selection" "this" {
  name         = "lppc-test-${random_uuid7.this.result}"
  plan_id      = aws_backup_plan.this.id
  iam_role_arn = aws_iam_role.this.arn

  resources = [
    "arn:aws:ec2:*:${data.aws_caller_identity.this.account_id}:volume/*"
  ]
}
