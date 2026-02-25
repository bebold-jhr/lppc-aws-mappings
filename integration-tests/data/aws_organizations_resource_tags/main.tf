data "aws_organizations_resource_tags" "this" {
  resource_id = var.aws_account_id
}
