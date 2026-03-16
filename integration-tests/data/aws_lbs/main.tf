data "aws_lbs" "this" {
  tags = {
    LppcTest = var.tag_value
  }
}
