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
