resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "aws_iam_account_alias" "this" {
  account_alias = "lppc-integration-test-${random_integer.suffix.result}"
}
