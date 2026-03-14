resource "random_uuid7" "this" {}

resource "aws_servicecatalog_portfolio" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  description   = "lppc integration test portfolio"
  provider_name = "lppc-test"
}
