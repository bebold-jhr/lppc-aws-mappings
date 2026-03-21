resource "random_uuid7" "this" {}

resource "aws_ecr_repository" "this" {
  name = random_uuid7.this.result
}
