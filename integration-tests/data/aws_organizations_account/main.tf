data "aws_organizations_account" "this" {
  account_id = var.aws_account_id
}
