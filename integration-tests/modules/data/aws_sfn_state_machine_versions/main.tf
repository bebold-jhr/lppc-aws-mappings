resource "random_uuid7" "this" {}

resource "aws_iam_role" "this" {
  name = "${random_uuid7.this.result}-rg"
  path = "/lppc/integration-tests/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_sfn_state_machine" "this" {
  name     = "${random_uuid7.this.result}-rg"
  role_arn = aws_iam_role.this.arn
  publish  = true

  definition = jsonencode({
    Comment = "A simple pass state"
    StartAt = "Pass"
    States = {
      Pass = {
        Type = "Pass"
        End  = true
      }
    }
  })
}
