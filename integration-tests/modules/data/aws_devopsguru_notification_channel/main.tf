resource "random_uuid7" "this" {}

resource "aws_sns_topic" "this" {
  name = "lppc-test-${random_uuid7.this.id}"
}

resource "aws_devopsguru_notification_channel" "this" {
  sns {
    topic_arn = aws_sns_topic.this.arn
  }
}
