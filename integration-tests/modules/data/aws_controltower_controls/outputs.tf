output "organization" {
  value = data.aws_organizations_organization.this
}

output "organizational_units" {
  value = data.aws_organizations_organizational_units.root
}
