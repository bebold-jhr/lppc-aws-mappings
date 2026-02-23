resource "random_uuid7" "this" {}

resource "aws_s3_bucket" "this" {
  bucket = "${random_uuid7.this.result}-rg"
}
