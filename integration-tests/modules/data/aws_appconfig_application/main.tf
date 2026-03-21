resource "random_uuid7" "this" {}

resource "aws_appconfig_application" "this" {
  name        = "${random_uuid7.this.result}-rg"
  description = "Integration test application"
}
