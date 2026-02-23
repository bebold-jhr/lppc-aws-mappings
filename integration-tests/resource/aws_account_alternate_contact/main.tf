resource "aws_account_alternate_contact" "this" {
  account_id             = var.aws_account_id
  alternate_contact_type = "OPERATIONS"
  title                  = "Integration Test"
  name                   = "Integration Test"
  email_address          = var.test_email
  phone_number           = var.test_phone_number
}
