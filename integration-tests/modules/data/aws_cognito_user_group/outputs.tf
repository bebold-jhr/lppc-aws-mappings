output "user_pool" {
  value = aws_cognito_user_pool.this
}

output "user_group" {
  value = aws_cognito_user_group.this
}
