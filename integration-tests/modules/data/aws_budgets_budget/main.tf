resource "random_uuid7" "this" {}

resource "aws_budgets_budget" "this" {
  name         = "lppc-test-${random_uuid7.this.result}"
  budget_type  = "COST"
  limit_amount = "100"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}
