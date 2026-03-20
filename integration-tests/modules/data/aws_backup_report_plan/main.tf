resource "random_uuid7" "this" {}

resource "aws_s3_bucket" "this" {
  bucket = "${random_uuid7.this.result}-lppc-test"
}

resource "aws_backup_report_plan" "this" {
  name = "lppc_test_${replace(random_uuid7.this.result, "-", "_")}"

  report_delivery_channel {
    s3_bucket_name = aws_s3_bucket.this.bucket
  }

  report_setting {
    report_template = "BACKUP_JOB_REPORT"
  }
}
