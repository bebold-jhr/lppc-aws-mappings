variable "management_account_id" {
  type        = string
  description = "The AWS management account id that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.management_account_id))
    error_message = "Invalid AWS account ID."
  }
}

####
# Prepare test setup
####
provider "aws" {
  region = "us-east-1"
  alias  = "test_setup_creator"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/ResourceAwsOrganizationsPolicy"
  }
}

run "prepare_test_setup" {
  state_key = "test_setup"

  module {
    source = "../../modules/resource/aws_organizations_tag"
  }

  providers = {
    aws = aws.test_setup_creator
  }

  command = apply
}

####
# We are using the management account
####
provider "aws" {
  region = "us-east-1"
  alias  = "management_account"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/ResourceAwsOrganizationsTag"
  }
}

####
# Perform tests
####
run "create_tag" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    resource_id = run.prepare_test_setup.policy.id
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsOrganizationsTag")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }
}
