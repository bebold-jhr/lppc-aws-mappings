data "aws_batch_job_definition" "this" {
  name = var.job_definition_name
}
