output "notification_channel" {
  value = aws_devopsguru_notification_channel.this
}

output "sns_topic" {
  value = aws_sns_topic.this
}
