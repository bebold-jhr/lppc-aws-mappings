resource "aws_organizations_policy" "this" {
  name = var.name
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

  tags = var.tags
}