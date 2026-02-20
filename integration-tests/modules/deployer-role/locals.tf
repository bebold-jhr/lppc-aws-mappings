locals {
  block_type         = basename(abspath("${path.cwd}/.."))
  resource_type      = basename(path.cwd)
  mappings_file_path = fileexists("../../../mappings/${local.block_type}/${local.resource_type}.yaml") ? "../../../mappings/${local.block_type}/${local.resource_type}.yaml" : "./placeholder-for-validation.yaml"
  mappings_file      = abspath(local.mappings_file_path)

  yaml_decoded = yamldecode(file(local.mappings_file))
  allow        = local.yaml_decoded["allow"] != null ? local.yaml_decoded["allow"] : []

  conditional_exists = lookup(local.yaml_decoded, "conditional", null) != null
  conditional        = regexall("\\w+:\\w+", local.conditional_exists ? yamlencode(local.yaml_decoded["conditional"]) : "")

  permissions = setunion(toset(local.allow), toset(local.conditional))
}