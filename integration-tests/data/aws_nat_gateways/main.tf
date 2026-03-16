data "aws_nat_gateways" "this" {
  vpc_id = var.vpc_id

  filter {
    name   = "state"
    values = ["available"]
  }
}
