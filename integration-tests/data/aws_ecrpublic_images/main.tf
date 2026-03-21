data "aws_ecrpublic_images" "this" {
  repository_name = var.repository_name
}
