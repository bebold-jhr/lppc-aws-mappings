resource "random_uuid7" "this" {}

resource "aws_eip" "this" {
  tags = {
    Name = "lppc-${random_uuid7.this.result}"
  }
}
