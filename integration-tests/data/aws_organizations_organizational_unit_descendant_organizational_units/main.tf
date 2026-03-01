data "aws_organizations_organizational_unit_descendant_organizational_units" "this" {
  parent_id = var.parent_id
}
