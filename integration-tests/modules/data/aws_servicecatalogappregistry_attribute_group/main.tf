resource "random_uuid7" "this" {}

resource "aws_servicecatalogappregistry_attribute_group" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  attributes = jsonencode({
    test = "value"
  })
}
