data "aws_lb_listener_rule" "this" {
  arn = var.listener_rule_arn
}
