data "aws_appconfig_environment" "this" {
  application_id = var.application_id
  environment_id = var.environment_id
}
