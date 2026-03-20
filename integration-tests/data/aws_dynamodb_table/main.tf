data "aws_dynamodb_table" "this" {
  name = var.table_name
}
