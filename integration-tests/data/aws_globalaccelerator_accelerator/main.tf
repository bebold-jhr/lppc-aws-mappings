data "aws_globalaccelerator_accelerator" "this" {
  name = var.accelerator_name
}
