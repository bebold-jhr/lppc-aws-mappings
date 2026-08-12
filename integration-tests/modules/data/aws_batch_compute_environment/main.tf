resource "random_uuid7" "this" {}

resource "aws_batch_compute_environment" "this" {
  compute_environment_name = "${random_uuid7.this.result}-rg"
  type                     = "UNMANAGED"
  state                    = "ENABLED"
}
