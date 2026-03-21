resource "random_uuid7" "this" {}

resource "aws_appconfig_application" "this" {
  name        = "${random_uuid7.this.result}-rg"
  description = "Integration test application"
}

resource "aws_appconfig_configuration_profile" "this" {
  application_id = aws_appconfig_application.this.id
  name           = "${random_uuid7.this.result}-rg"
  location_uri   = "hosted"
}
