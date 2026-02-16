####
# Set up deployer role
####
provider "aws" {
  region = "us-east-1"
  alias  = "admin"
}

run "create_deployer_role" {
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
run "successfully_create_vpc" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.deployer_role
  }

  command = apply

  assert {
    condition     = startswith(data.aws_caller_identity.this.arn, "arn:aws:sts::${run.create_deployer_role.account_id}:assumed-role/${run.create_deployer_role.deployer_role.name}")
    error_message = "Used wrong role."
  }

  assert {
    condition     = data.aws_caller_identity.this.account_id == run.create_deployer_role.account_id
    error_message = "Unexpected account ID."
  }

  assert {
    condition     = aws_vpc.this.id != null
    error_message = "VPC ID must not be null"
  }
}

run "modify_tenancy" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.deployer_role
  }

  command = apply

  variables {
    instance_tenancy = "dedicated"
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
    condition     = aws_vpc.this.instance_tenancy == "dedicated"
    error_message = "Expected instance_tenancy to be changed from 'default' to 'dedicated'."
  }
}