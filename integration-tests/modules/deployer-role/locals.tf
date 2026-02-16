locals {
  block_type         = basename(abspath("${path.cwd}/.."))
  resource_type      = basename(path.cwd)
  mappings_file_path = fileexists("../../../mappings/${local.block_type}/${local.resource_type}.yml") ? "../../../mappings/${local.block_type}/${local.resource_type}.yml" : "./placeholder-for-validation.yml"
  mappings_file      = abspath(local.mappings_file_path)

  yaml_decoded = yamldecode(file(local.mappings_file))
  actions      = local.yaml_decoded["actions"] != null ? local.yaml_decoded["actions"] : []

  optional_exists = lookup(local.yaml_decoded, "optional", null) != null
  optional        = regexall("\\w+:\\w+", local.optional_exists ? yamlencode(local.yaml_decoded["optional"]) : "")

  permissions = setunion(toset(local.actions), toset(local.optional))
}