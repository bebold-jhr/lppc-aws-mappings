resource "aws_organizations_policy" "this" {
  name = "lppc-integration-test"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "lambda:*"
        Resource = "*"
      }
    ]
  })
}