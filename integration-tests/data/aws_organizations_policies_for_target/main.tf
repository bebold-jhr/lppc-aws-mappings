data "aws_organizations_policies_for_target" "this" {
  target_id = var.aws_account_id
  filter    = "SERVICE_CONTROL_POLICY"
}
