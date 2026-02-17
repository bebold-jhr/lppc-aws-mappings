data "aws_ami" "this" {
  most_recent = true
  name_regex  = "amazon-eks-node-*"
  owners = [
    "amazon",
  ]

  filter {
    name = "root-device-type"
    values = [
      "ebs",
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm",
    ]
  }
}