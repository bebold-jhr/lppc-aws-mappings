output "account_id" {
  value = data.aws_caller_identity.admin.account_id
}

output "deployer_role" {
  depends_on = [
    time_sleep.deployer_role,
  ]
  value = {
    arn  = aws_iam_role.deployer_role.arn
    name = aws_iam_role.deployer_role.name
  }
}