data "aws_ecs_container_definition" "this" {
  task_definition = var.task_definition_arn
  container_name  = "app"
}
