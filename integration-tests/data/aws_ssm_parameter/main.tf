data "aws_ssm_parameter" "this" {
  name = var.parameter_name
}
