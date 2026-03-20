resource "random_uuid7" "this" {}

resource "aws_sqs_queue" "this" {
  name = "${random_uuid7.this.result}-rg"
}
