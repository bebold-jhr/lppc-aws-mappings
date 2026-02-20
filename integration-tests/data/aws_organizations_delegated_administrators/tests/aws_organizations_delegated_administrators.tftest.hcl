variable "management_account_id" {
  type        = string
  description = "The AWS management account id that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.management_account_id))
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
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/DataAwsOrganizationsDelegatedAdministrators"
  }
}

####
# Perform tests
####
run "list_delegated_admins" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/DataAwsOrganizationsDelegatedAdministrators")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = length(data.aws_organizations_delegated_administrators.this.delegated_administrators) > 0
    error_message = "Expected list of delegated admins to contain at least one entry."
  }
}
