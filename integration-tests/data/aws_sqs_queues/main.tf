data "aws_sqs_queues" "this" {
  queue_name_prefix = var.queue_name_prefix
}
