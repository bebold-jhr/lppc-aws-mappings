data "aws_codeartifact_repository_endpoint" "this" {
  domain     = var.domain
  repository = var.repository
  format     = "npm"
}
