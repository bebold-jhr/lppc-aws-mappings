resource "random_uuid" "this" {}

resource "aws_lb_target_group" "this" {
  name        = substr(random_uuid.this.result, 0, 32)
  target_type = "lambda"
}
