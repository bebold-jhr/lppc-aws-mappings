data "aws_athena_named_query" "this" {
  name = var.name
}
