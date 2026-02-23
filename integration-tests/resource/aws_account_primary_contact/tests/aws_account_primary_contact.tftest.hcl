variable "management_account_id" {
  type        = string
  description = "The AWS management account id that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.management_account_id))
    error_message = "Invalid AWS account ID."
  }
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account id for our test account that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.aws_account_id))
    error_message = "Invalid AWS account ID."
  }
}

variable "original_address_line_1" {
  type = string
}

variable "original_city" {
  type = string
}

variable "original_company_name" {
  type = string
}

variable "original_phone_number" {
  type = string
}

variable "original_postal_code" {
  type = string
}

variable "original_state_or_region" {
  type = string
}

variable "original_website_url" {
  type = string
}

####
# We are using the management account
####
provider "aws" {
  region = "us-east-1"
  alias  = "management_account"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/ResourceAwsAccountPrimaryContact"
  }
}

####
# Perform tests
####
run "change_primary_contact" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    account_id      = var.aws_account_id
    address_line_1  = var.original_address_line_1
    city            = var.original_city
    company_name    = var.original_company_name
    phone_number    = var.original_phone_number
    postal_code     = var.original_postal_code
    state_or_region = var.original_state_or_region
    website_url     = "https://example.org"
  }

  assert {
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsAccountPrimaryContact")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id != var.aws_account_id
    error_message = "Expected to see the ID of a member account not the ID of the management account."
  }
}

run "revert_primary_contact" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    account_id      = var.aws_account_id
    address_line_1  = var.original_address_line_1
    city            = var.original_city
    company_name    = var.original_company_name
    phone_number    = var.original_phone_number
    postal_code     = var.original_postal_code
    state_or_region = var.original_state_or_region
    website_url     = var.original_website_url
  }

  assert {
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsAccountPrimaryContact")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id != var.aws_account_id
    error_message = "Expected to see the ID of a member account not the ID of the management account."
  }
}