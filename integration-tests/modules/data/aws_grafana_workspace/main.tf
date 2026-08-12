resource "random_uuid7" "this" {}

resource "aws_iam_role" "grafana" {
  name = "lppc-test-grafana-${random_uuid7.this.result}"
  path = "/lppc/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "grafana.amazonaws.com"
      }
    }]
  })
}

resource "aws_grafana_workspace" "this" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["SAML"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = aws_iam_role.grafana.arn
  name                     = "lppc-test-${random_uuid7.this.result}"
}
