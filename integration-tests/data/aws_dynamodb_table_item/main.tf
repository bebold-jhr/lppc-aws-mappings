data "aws_dynamodb_table_item" "this" {
  table_name = var.table_name
  key        = var.key
}
