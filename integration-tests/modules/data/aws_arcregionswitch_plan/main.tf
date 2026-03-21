resource "random_uuid7" "this" {}

resource "aws_iam_role" "this" {
  name = "lppc-test-arc-plan-exec-${random_uuid7.this.result}"
  path = "/lppc/integration-tests/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "arc-region-switch.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_arcregionswitch_plan" "this" {
  name              = "lppc-test-${substr(random_uuid7.this.result, 0, 22)}"
  execution_role    = aws_iam_role.this.arn
  recovery_approach = "activePassive"
  regions           = ["us-east-1", "us-west-2"]
  primary_region    = "us-east-1"

  workflow {
    workflow_target_action = "activate"
    workflow_target_region = "us-east-1"

    step {
      name                 = "manual-approval"
      execution_block_type = "ManualApproval"

      execution_approval_config {
        approval_role   = aws_iam_role.this.arn
        timeout_minutes = 60
      }
    }
  }

  workflow {
    workflow_target_action = "activate"
    workflow_target_region = "us-west-2"

    step {
      name                 = "manual-approval"
      execution_block_type = "ManualApproval"

      execution_approval_config {
        approval_role   = aws_iam_role.this.arn
        timeout_minutes = 60
      }
    }
  }
}
