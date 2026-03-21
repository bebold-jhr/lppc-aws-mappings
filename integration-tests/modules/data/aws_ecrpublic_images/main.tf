resource "random_uuid7" "this" {}

resource "aws_ecrpublic_repository" "this" {
  repository_name = random_uuid7.this.result
}
