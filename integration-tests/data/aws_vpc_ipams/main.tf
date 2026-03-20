data "aws_vpc_ipams" "this" {
  filter {
    name   = "ipam-id"
    values = [var.ipam_id]
  }
}
