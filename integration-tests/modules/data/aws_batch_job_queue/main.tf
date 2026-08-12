resource "random_uuid7" "this" {}

resource "aws_batch_compute_environment" "this" {
  compute_environment_name = "${random_uuid7.this.result}-ce"
  type                     = "UNMANAGED"
  state                    = "ENABLED"
}

resource "aws_batch_job_queue" "this" {
  name     = "${random_uuid7.this.result}-rg"
  state    = "ENABLED"
  priority = 1

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.this.arn
  }
}
