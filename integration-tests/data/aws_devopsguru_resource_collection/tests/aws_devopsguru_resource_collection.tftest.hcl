variable "aws_account_id" {
  type        = string
  description = "The AWS account id for our test account that we get injected from the github workflow."

  validation {
    condition     = can(regex("^\\d{12}$", var.aws_account_id))
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
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/lppc/LppcTestSetupCreator"
  }
}

run "prepare_test_setup" {
  state_key = "test_setup"

  module {
    source = "../../modules/data/aws_devopsguru_resource_collection"
  }

  providers = {
    aws = aws.test_setup_creator
  }

  command = apply
}

####
# Set up deployer role
####
provider "aws" {
  region = "us-east-1"
  alias  = "admin"
}

run "create_deployer_role" {
  state_key = "deployer_role"

  module {
    source = "../../modules/deployer-role"
  }

  providers = {
    aws = aws.admin
  }
}

####
# Provider using deployer role
####
provider "aws" {
  region = "us-east-1"
  alias  = "deployer_role"

  assume_role {
    role_arn = run.create_deployer_role.deployer_role.arn
  }
}

####
# Perform tests
####
run "fetch_devopsguru_resource_collection" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.deployer_role
  }

  command = apply

  variables {
    resource_collection_type = run.prepare_test_setup.resource_collection.type
  }

  assert {
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${run.create_deployer_role.account_id}:assumed-role/${run.create_deployer_role.deployer_role.name}")
    error_message = "Used wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == run.create_deployer_role.account_id
    error_message = "Unexpected account ID."
  }

  assert {
    condition     = data.aws_devopsguru_resource_collection.this.type == "AWS_TAGS"
    error_message = "Expected resource collection type to be AWS_TAGS."
  }

  assert {
    condition     = data.aws_devopsguru_resource_collection.this.tags[0].app_boundary_key == "DevOps-Guru-lppc-test"
    error_message = "Expected app_boundary_key to be 'DevOps-Guru-lppc-test'."
  }
}
