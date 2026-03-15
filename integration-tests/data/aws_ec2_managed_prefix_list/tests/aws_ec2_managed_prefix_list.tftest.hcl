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
run "fetch_managed_prefix_list" {
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
    condition     = data.aws_ec2_managed_prefix_list.this.name == "com.amazonaws.us-east-1.s3"
    error_message = "Expected managed prefix list name to be com.amazonaws.us-east-1.s3."
  }

  assert {
    condition     = data.aws_ec2_managed_prefix_list.this.owner_id == "AWS"
    error_message = "Expected managed prefix list owner to be AWS."
  }
}
