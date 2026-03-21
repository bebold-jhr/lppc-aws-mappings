resource "random_uuid7" "this" {}

resource "aws_codecommit_approval_rule_template" "this" {
  name = "lppc-test-${random_uuid7.this.result}"

  content = jsonencode({
    Version = "2018-11-08"
    Statements = [{
      Type                    = "Approvers"
      NumberOfApprovalsNeeded = 1
    }]
  })
}
