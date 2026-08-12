resource "random_uuid7" "this" {}

resource "aws_codeartifact_domain" "this" {
  domain = "lppc-test-${random_uuid7.this.result}"
}

resource "aws_codeartifact_repository" "this" {
  repository = "lppc-test-${random_uuid7.this.result}"
  domain     = aws_codeartifact_domain.this.domain
}
