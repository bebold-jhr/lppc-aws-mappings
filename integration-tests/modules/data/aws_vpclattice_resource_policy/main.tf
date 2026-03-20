resource "random_uuid" "this" {}

data "aws_caller_identity" "this" {}

resource "aws_vpclattice_service_network" "this" {
  name = "lppc-test-${random_uuid.this.result}"
}

resource "aws_vpclattice_resource_policy" "this" {
  resource_arn = aws_vpclattice_service_network.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowAccess"
      Effect    = "Allow"
      Principal = { "AWS" = data.aws_caller_identity.this.account_id }
      Action    = "vpc-lattice:CreateServiceNetworkVpcAssociation"
      Resource  = aws_vpclattice_service_network.this.arn
    }]
  })
}
