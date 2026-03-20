data "aws_network_interfaces" "this" {
  filter {
    name   = "network-interface-id"
    values = [var.network_interface_id]
  }
}
