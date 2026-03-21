resource "random_uuid7" "this" {}

resource "aws_ecr_repository_creation_template" "this" {
  prefix               = random_uuid7.this.result
  applied_for          = ["CREATE_ON_PUSH"]
  image_tag_mutability = "IMMUTABLE"
}
