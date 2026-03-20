data "aws_vpc_security_group_rules" "this" {
  filter {
    name   = "group-id"
    values = [var.security_group_id]
  }
}
