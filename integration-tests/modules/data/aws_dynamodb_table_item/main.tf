resource "random_uuid" "this" {}

resource "aws_dynamodb_table" "this" {
  name         = "lppc-test-${random_uuid.this.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = jsonencode({
    "id"   = { "S" = "test-item-${random_uuid.this.result}" }
    "name" = { "S" = "test-value" }
  })
}
