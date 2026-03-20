resource "random_uuid7" "this" {}

resource "aws_servicecatalogappregistry_application" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}
