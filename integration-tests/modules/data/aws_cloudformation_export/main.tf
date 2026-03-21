resource "random_uuid7" "this" {}

resource "aws_cloudformation_stack" "this" {
  name = "lppc-test-${random_uuid7.this.id}"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Resources = {
      WaitHandle = {
        Type = "AWS::CloudFormation::WaitConditionHandle"
      }
    }
    Outputs = {
      TestExport = {
        Value = "test-export-value"
        Export = {
          Name = "lppc-test-export-${random_uuid7.this.id}"
        }
      }
    }
  })
}
