data "aws_eks_addon_version" "this" {
  addon_name         = var.addon_name
  kubernetes_version = var.kubernetes_version
}
