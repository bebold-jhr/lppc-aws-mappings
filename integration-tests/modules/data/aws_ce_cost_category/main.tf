resource "random_uuid7" "this" {}

resource "aws_ce_cost_category" "this" {
  name         = "lppc-test-${random_uuid7.this.result}"
  rule_version = "CostCategoryExpression.v1"

  rule {
    value = "test"
    rule {
      dimension {
        key           = "LINKED_ACCOUNT_NAME"
        values        = ["lppc-test-nonexistent"]
        match_options = ["EQUALS"]
      }
    }
  }
}
