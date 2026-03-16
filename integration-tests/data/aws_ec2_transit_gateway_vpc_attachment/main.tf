data "aws_ec2_transit_gateway_vpc_attachment" "this" {
  id = var.attachment_id
}
