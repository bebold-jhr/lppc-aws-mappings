output "autoscaling_group" {
  value = aws_autoscaling_group.this
}

output "test_id" {
  value = random_uuid7.this.result
}
