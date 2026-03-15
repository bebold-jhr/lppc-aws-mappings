data "aws_ssm_document" "this" {
  name            = "AWS-GatherSoftwareInventory"
  document_format = "YAML"
}
