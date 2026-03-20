data "aws_sfn_alias" "this" {
  name             = var.alias_name
  statemachine_arn = var.statemachine_arn
}
