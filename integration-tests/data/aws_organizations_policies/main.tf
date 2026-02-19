data "aws_organizations_policies" "this" {
  filter = "SERVICE_CONTROL_POLICY"
}
