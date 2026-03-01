resource "aws_organizations_resource_policy" "this" {
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Principal = {
          AWS = var.account_id
        }
        Effect = "Allow"
        Action = [
          "organizations:ListRoots",
        ]
        Resource = "*"
      }
    ]
  })
}
