data "aws_devopsguru_notification_channel" "this" {
  id = var.notification_channel_id
}
