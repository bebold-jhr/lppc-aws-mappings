data "aws_batch_scheduling_policy" "this" {
  arn = var.scheduling_policy_arn
}
