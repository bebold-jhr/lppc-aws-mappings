resource "aws_account_primary_contact" "this" {
  account_id      = var.aws_account_id
  address_line_1  = var.address_line_1
  city            = var.city
  company_name    = var.company_name
  country_code    = "DE"
  full_name       = "lppc-integration-tests"
  phone_number    = var.phone_number
  postal_code     = var.postal_code
  state_or_region = var.state_or_region
  website_url     = var.website_url
}