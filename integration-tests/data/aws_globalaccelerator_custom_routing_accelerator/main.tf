data "aws_globalaccelerator_custom_routing_accelerator" "this" {
  name = var.accelerator_name
}
