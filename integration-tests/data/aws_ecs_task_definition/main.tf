data "aws_ecs_task_definition" "this" {
  task_definition = var.task_definition_family
}
