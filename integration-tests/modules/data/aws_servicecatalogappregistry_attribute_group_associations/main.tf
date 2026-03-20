resource "random_uuid7" "this" {}

resource "aws_servicecatalogappregistry_application" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_servicecatalogappregistry_attribute_group" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  attributes = jsonencode({
    test = "value"
  })
}

resource "aws_servicecatalogappregistry_attribute_group_association" "this" {
  application_id     = aws_servicecatalogappregistry_application.this.id
  attribute_group_id = aws_servicecatalogappregistry_attribute_group.this.id
}
