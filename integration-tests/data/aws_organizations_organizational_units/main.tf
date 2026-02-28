data "aws_organizations_organizational_units" "this" {
  parent_id = var.parent_id
}
