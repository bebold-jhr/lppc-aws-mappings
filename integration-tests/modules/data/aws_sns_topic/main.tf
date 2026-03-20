resource "random_uuid7" "this" {}

resource "aws_sns_topic" "this" {
  name = "${random_uuid7.this.result}-rg"
}
