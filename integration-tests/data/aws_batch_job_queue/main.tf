data "aws_batch_job_queue" "this" {
  name = var.job_queue_name
}
