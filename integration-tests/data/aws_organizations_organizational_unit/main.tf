data "aws_organizations_organizational_unit" "this" {
  parent_id = var.parent_id
  name      = "sandbox"
}
