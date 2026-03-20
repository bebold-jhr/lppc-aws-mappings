resource "random_uuid7" "this" {}

resource "aws_sfn_activity" "this" {
  name = "${random_uuid7.this.result}-rg"
}
