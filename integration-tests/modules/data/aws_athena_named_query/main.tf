resource "random_uuid7" "this" {}

resource "aws_glue_catalog_database" "this" {
  name = replace(random_uuid7.this.result, "-", "")
}

resource "aws_athena_named_query" "this" {
  name     = random_uuid7.this.result
  database = aws_glue_catalog_database.this.name
  query    = "SELECT 1"
}
