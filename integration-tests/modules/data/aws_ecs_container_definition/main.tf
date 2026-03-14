resource "random_uuid7" "this" {}

resource "aws_ecs_task_definition" "this" {
  family = "lppc-${random_uuid7.this.result}"

  container_definitions = jsonencode([{
    name      = "app"
    image     = "public.ecr.aws/docker/library/nginx:latest"
    essential = true
    cpu       = 128
    memory    = 128
  }])
}
