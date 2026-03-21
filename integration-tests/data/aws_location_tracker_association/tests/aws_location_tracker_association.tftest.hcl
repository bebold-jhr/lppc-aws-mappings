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
    source = "../../modules/data/aws_location_tracker_association"
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
run "fetch_tracker_association" {
  state_key = "main"

  module {
    source = "./"
  }

  providers = {
    aws = aws.deployer_role
  }

  command = apply

  variables {
    tracker_name = run.prepare_test_setup.tracker.tracker_name
    consumer_arn = run.prepare_test_setup.geofence_collection.collection_arn
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
    condition     = data.aws_location_tracker_association.this.tracker_name == run.prepare_test_setup.tracker.tracker_name
    error_message = "Expected tracker name to match the one from test setup."
  }

  assert {
    condition     = data.aws_location_tracker_association.this.consumer_arn == run.prepare_test_setup.geofence_collection.collection_arn
    error_message = "Expected consumer ARN to match the one from test setup."
  }
}
