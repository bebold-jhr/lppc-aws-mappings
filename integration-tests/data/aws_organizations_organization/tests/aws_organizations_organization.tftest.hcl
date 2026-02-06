variable "management_account_id" {
  type = string
}

####
# Set up deployer role
####
provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.management_account_id}:role/lppc/AwsOrganizationsOrganization"
  }
}

####
# Perform tests
####
run "retrieve_organization_data" {
  state_key = "main"

  module {
    source = "./"
  }

  command = apply

  assert {
    condition     = data.aws_caller_identity.this.account_id == data.aws_organizations_organization.this.master_account_id
    error_message = "Expected current account to be management account."
  }
}
