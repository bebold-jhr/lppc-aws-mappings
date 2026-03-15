data "aws_ec2_transit_gateway_attachment" "this" {
  transit_gateway_attachment_id = var.attachment_id
}
