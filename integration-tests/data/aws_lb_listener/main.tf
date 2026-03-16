data "aws_lb_listener" "this" {
  arn = var.listener_arn
}
