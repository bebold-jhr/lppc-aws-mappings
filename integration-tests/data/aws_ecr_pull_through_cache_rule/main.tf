data "aws_ecr_pull_through_cache_rule" "this" {
  ecr_repository_prefix = var.ecr_repository_prefix
}
