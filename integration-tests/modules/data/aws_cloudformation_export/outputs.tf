output "stack" {
  value = aws_cloudformation_stack.this
}

output "export_name" {
  value = "lppc-test-export-${random_uuid7.this.id}"
}
