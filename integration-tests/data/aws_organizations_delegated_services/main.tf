data "aws_organizations_delegated_services" "this" {
  account_id = var.delegated_admin_account_id
}
