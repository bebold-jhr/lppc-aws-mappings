resource "random_uuid7" "this" {}

resource "aws_dms_endpoint" "this" {
  endpoint_id   = "lppc-test-${random_uuid7.this.result}"
  endpoint_type = "source"
  engine_name   = "mysql"
  server_name   = "example.com"
  port          = 3306
  database_name = "test"
  username      = "test"
  password      = "test"
}
