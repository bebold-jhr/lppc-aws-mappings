data "aws_instances" "this" {
  filter {
    name   = "instance-id"
    values = [var.instance_id]
  }
}
