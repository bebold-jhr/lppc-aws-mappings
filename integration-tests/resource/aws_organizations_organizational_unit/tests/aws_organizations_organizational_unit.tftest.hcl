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
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/DataAwsOrganizationsOrganization"
  }
}

run "prepare_test_setup" {
  state_key = "test_setup"

  module {
    source = "../../modules/resource/aws_organizations_organizational_unit"
  }

  providers = {
    aws = aws.test_setup_creator
  }
}

####
# We are using the management account
####
provider "aws" {
  region = "us-east-1"
  alias  = "management_account"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/ResourceAwsOrganizationsOrganizationalUnit"
  }
}

####
# Perform tests
####
run "create_ou" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    parent = run.prepare_test_setup.organization.roots[0].id
    name   = "integration-test"
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsOrganizationsOrganizationalUnit")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }

  assert {
    condition     = aws_organizations_organizational_unit.this.id != null && length(aws_organizations_organizational_unit.this.id) > 0
    error_message = "Expected ou to be created successfully."
  }
}

run "change_ou_name" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    parent = run.prepare_test_setup.organization.roots[0].id
    name   = "changed-name"
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsOrganizationsOrganizationalUnit")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }
}

run "tag_ou" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    parent = run.prepare_test_setup.organization.roots[0].id
    name   = "changed-name"
    tags = {
      createdBy = "integration-test"
    }
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsOrganizationsOrganizationalUnit")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }

  assert {
    condition     = lookup(aws_organizations_organizational_unit.this.tags_all, "createdBy", null) == "integration-test"
    error_message = "Expected account to contain tag 'createdBy' with value 'integration-test'"
  }
}

run "untag_ou" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.management_account
  }

  command = apply

  variables {
    parent = run.prepare_test_setup.organization.roots[0].id
    name   = "changed-name"
    tags   = {}
  }

  assert {
    # Note: role path gets stripped here
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${var.management_account_id}:assumed-role/ResourceAwsOrganizationsOrganizationalUnit")
    error_message = "Used the wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == var.management_account_id
    error_message = "Expected current account to be the management account."
  }

  assert {
    condition     = length(aws_organizations_organizational_unit.this.tags_all) == 0
    error_message = "Expected tags to be empty."
  }
}
