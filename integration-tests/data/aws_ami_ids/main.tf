data "aws_ami_ids" "this" {
  owners = [
    "amazon"
  ]

  filter {
    name = "name"
    values = [
      "amazon-eks-node-*",
    ]
  }
}
