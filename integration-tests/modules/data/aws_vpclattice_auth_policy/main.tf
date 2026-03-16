resource "random_uuid" "this" {}

resource "aws_vpclattice_service" "this" {
  name      = "lppc-test-${substr(random_uuid.this.result, 0, 29)}"
  auth_type = "AWS_IAM"
}

resource "aws_vpclattice_auth_policy" "this" {
  resource_identifier = aws_vpclattice_service.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "vpc-lattice-svcs:Invoke"
      Resource  = "*"
    }]
  })
}
