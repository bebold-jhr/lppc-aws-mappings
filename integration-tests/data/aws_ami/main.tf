data "aws_ami" "this" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "^amazon/ubuntu-eks-pro*"
  owners           = ["amazon"]
}
