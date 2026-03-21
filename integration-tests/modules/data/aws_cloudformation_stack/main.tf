resource "random_uuid7" "this" {}

resource "aws_cloudformation_stack" "this" {
  name = "lppc-test-${random_uuid7.this.id}"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Description              = "LPPC integration test stack"
    Resources = {
      WaitHandle = {
        Type = "AWS::CloudFormation::WaitConditionHandle"
      }
    }
    Outputs = {
      TestOutput = {
        Value       = "test-output-value"
        Description = "A test output"
      }
    }
  })

  tags = {
    Purpose = "lppc-integration-test"
  }
}
