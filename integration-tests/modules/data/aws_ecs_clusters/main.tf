resource "random_uuid7" "this" {}

resource "aws_ecs_cluster" "this" {
  name = "lppc-${random_uuid7.this.result}"
}
