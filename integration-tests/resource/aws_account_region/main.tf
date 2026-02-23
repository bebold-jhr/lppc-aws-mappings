resource "aws_account_region" "this" {
  account_id  = var.aws_account_id
  enabled     = var.enabled
  region_name = "eu-south-2"
}
