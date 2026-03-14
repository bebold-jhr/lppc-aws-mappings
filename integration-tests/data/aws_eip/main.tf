data "aws_eip" "this" {
  id = var.allocation_id
}
