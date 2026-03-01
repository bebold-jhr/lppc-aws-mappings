data "aws_organizations_organizational_unit_child_accounts" "this" {
  parent_id = var.parent_id
}
