resource "random_uuid7" "this" {}

resource "aws_s3_bucket" "template" {
  bucket        = "${random_uuid7.this.result}-sc"
  force_destroy = true
}

resource "aws_s3_object" "template" {
  bucket       = aws_s3_bucket.template.bucket
  key          = "template.json"
  content_type = "application/json"

  content = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Resources = {
      WaitHandle = {
        Type = "AWS::CloudFormation::WaitConditionHandle"
      }
    }
  })
}

resource "aws_servicecatalog_product" "this" {
  name  = "lppc-test-${random_uuid7.this.result}"
  owner = "lppc-test"
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    name                        = "v1"
    type                        = "CLOUD_FORMATION_TEMPLATE"
    template_url                = "https://s3.amazonaws.com/${aws_s3_bucket.template.bucket}/${aws_s3_object.template.key}"
    disable_template_validation = true
  }
}

resource "aws_servicecatalog_portfolio" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  description   = "lppc integration test portfolio"
  provider_name = "lppc-test"
}

resource "aws_servicecatalog_product_portfolio_association" "this" {
  portfolio_id = aws_servicecatalog_portfolio.this.id
  product_id   = aws_servicecatalog_product.this.id
}

resource "aws_sns_topic" "this" {
  name = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_servicecatalog_constraint" "this" {
  portfolio_id = aws_servicecatalog_portfolio.this.id
  product_id   = aws_servicecatalog_product.this.id
  type         = "NOTIFICATION"

  parameters = jsonencode({
    NotificationArns = [aws_sns_topic.this.arn]
  })

  depends_on = [aws_servicecatalog_product_portfolio_association.this]
}
