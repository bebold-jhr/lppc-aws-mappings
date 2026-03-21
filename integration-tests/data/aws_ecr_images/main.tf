data "aws_ecr_images" "this" {
  repository_name = var.repository_name
}
