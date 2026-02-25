data "aws_organizations_entity_path" "this" {
  entity_id = var.aws_account_id
}
