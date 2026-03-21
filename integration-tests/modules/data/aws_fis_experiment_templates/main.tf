resource "random_uuid7" "this" {}

resource "aws_iam_role" "fis" {
  name = random_uuid7.this.result
  path = "/lppc/integration-tests/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "fis.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_fis_experiment_template" "this" {
  description = "lppc-test-${random_uuid7.this.result}"
  role_arn    = aws_iam_role.fis.arn

  stop_condition {
    source = "none"
  }

  action {
    name        = "wait"
    action_id   = "aws:fis:wait"
    description = "Wait action for testing"

    parameter {
      key   = "duration"
      value = "PT1M"
    }
  }

  tags = {
    Name = "lppc-test-${random_uuid7.this.result}"
  }
}
