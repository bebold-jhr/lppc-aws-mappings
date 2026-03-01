resource "aws_organizations_tag" "this" {
  resource_id = var.resource_id
  key         = "ExampleKey"
  value       = "ExampleValue"
}
