resource "random_uuid7" "this" {}

resource "aws_ecr_pull_through_cache_rule" "this" {
  ecr_repository_prefix = substr(random_uuid7.this.result, 0, 20)
  upstream_registry_url = "public.ecr.aws"
}
