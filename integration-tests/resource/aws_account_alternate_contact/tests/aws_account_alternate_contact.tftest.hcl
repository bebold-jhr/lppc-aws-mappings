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

variable "original_phone_number" {
  type = string
}

####
# We are using the management account
####
provider "aws" {
  region = "us-east-1"
  alias  = "management_account"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/ResourceAwsAccountAlternateContact"
  }
}

####
# Perform tests
####
run "create_alternate_contact" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    phone_number = var.original_phone_number
  }

  assert {
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsAccountAlternateContact")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id != var.aws_account_id
    error_message = "Expected to see the ID of a member account not the ID of the management account."
  }
}