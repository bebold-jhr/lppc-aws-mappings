data "aws_codecommit_approval_rule_template" "this" {
  name = var.approval_rule_template_name
}
