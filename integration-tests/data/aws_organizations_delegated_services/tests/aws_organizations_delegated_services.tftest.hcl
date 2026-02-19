variable "management_account_id" {
  type        = string
  description = "The AWS management account id that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.management_account_id))
    error_message = "Invalid AWS account ID."
  }
}

variable "delegated_admin_account_id" {
  type        = string
  description = "AWS account id for a delegated admin that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.delegated_admin_account_id))
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
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/DataAwsOrganizationsDelegatedServices"
  }
}

####
# Perform tests
####
run "fetch_delegated_services" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    delegated_admin_account_id = var.delegated_admin_account_id
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/DataAwsOrganizationsDelegatedServices")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = length(data.aws_organizations_delegated_services.this.delegated_services) > 0
    error_message = "Expected list of delegated services to contain at least one entry."
  }
}
