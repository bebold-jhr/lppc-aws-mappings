resource "aws_account_alternate_contact" "this" {
  account_id             = var.aws_account_id
  alternate_contact_type = "OPERATIONS"
  title                  = "Integration Test"
  name                   = "Integration Test"
  email_address          = "integrationtest@example.org"
  phone_number           = var.phone_number
}
