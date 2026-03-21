resource "random_uuid7" "this" {}

data "aws_caller_identity" "this" {}

resource "aws_kinesis_stream" "this" {
  name        = "lppc-test-${random_uuid7.this.result}"
  shard_count = 1
}

resource "aws_iam_role" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
  path = "/lppc/integration-tests/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  name = "kinesis-access"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kinesis:DescribeStream",
          "kinesis:DescribeStreamSummary",
          "kinesis:PutRecord",
          "kinesis:PutRecords"
        ]
        Resource = aws_kinesis_stream.this.arn
      }
    ]
  })
}

resource "aws_cloudfront_realtime_log_config" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  sampling_rate = 1
  fields        = ["timestamp", "c-ip"]

  endpoint {
    stream_type = "Kinesis"

    kinesis_stream_config {
      role_arn   = aws_iam_role.this.arn
      stream_arn = aws_kinesis_stream.this.arn
    }
  }
}
