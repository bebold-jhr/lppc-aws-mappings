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

####
# We are using the management account
####
provider "aws" {
  region = "us-east-1"
  alias  = "management_account"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/DataAwsOrganizationsAccount"
  }
}

####
# Perform tests
####
run "fetch_tags" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    aws_account_id = var.aws_account_id
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/DataAwsOrganizationsAccount")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }

  assert {
    condition     = lookup(data.aws_organizations_resource_tags.this.tags, "type", null) == "sandbox"
    error_message = "Expected account to contain tag 'type' with value 'sandbox'"
  }
}
