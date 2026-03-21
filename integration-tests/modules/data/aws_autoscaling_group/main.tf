data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "random_uuid7" "this" {}

resource "aws_launch_template" "this" {
  name          = "lppc-test-${random_uuid7.this.result}"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
}

resource "aws_autoscaling_group" "this" {
  name               = "lppc-test-${random_uuid7.this.result}"
  min_size           = 0
  max_size           = 0
  desired_capacity   = 0
  availability_zones = ["us-east-1a"]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}
