data "aws_organizations_organizational_unit_descendant_accounts" "this" {
  parent_id = var.parent_id
}
