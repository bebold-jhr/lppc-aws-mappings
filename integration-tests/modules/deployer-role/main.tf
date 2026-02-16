resource "random_uuid" "name" {}

resource "aws_iam_role" "deployer_role" {
  name                 = random_uuid.name.result
  path                 = "/lppc/deployer-roles/"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.admin.account_id}:policy/LppcDeployerRolePermissionBoundary"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_caller_identity.admin.account_id
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "deployer_role" {
  role = aws_iam_role.deployer_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = local.permissions
        Resource = "*"
      },
    ]
  })
}

/*
  Even if the creation of roles an policies by terraform is successful, these resources seem to be eventual
  consistent, because it takes some time to be available for use.
*/
resource "time_sleep" "deployer_role" {
  depends_on = [
    aws_iam_role.deployer_role,
    aws_iam_role_policy.deployer_role,
  ]

  create_duration = "10s"
}