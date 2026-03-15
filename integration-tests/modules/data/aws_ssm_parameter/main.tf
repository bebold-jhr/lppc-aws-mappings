resource "random_uuid7" "this" {}

resource "aws_ssm_parameter" "this" {
  name  = "/${random_uuid7.this.result}/test"
  type  = "String"
  value = "test-value"
}
