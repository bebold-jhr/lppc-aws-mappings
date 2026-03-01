resource "aws_organizations_policy_attachment" "this" {
  policy_id = var.policy
  target_id = var.target
}
