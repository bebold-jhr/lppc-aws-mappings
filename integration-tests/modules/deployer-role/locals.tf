locals {
  block_type         = basename(abspath("${path.cwd}/.."))
  resource_type      = basename(path.cwd)
  mappings_file_path = fileexists("../../../mappings/${local.block_type}/${local.resource_type}.yaml") ? "../../../mappings/${local.block_type}/${local.resource_type}.yaml" : "./placeholder-for-validation.yaml"
  mappings_file      = abspath(local.mappings_file_path)
  yaml_decoded       = yamldecode(file(local.mappings_file))

  allow_key = "allow"
  allow     = lookup(local.yaml_decoded, local.allow_key, null) != null && length(local.yaml_decoded[local.allow_key]) > 0 ? local.yaml_decoded[local.allow_key] : []

  deny_key = "deny"
  deny     = lookup(local.yaml_decoded, local.deny_key, null) != null && length(local.yaml_decoded[local.deny_key]) > 0 ? local.yaml_decoded[local.deny_key] : []
  deny_statement = length(local.deny) > 0 ? {
    Effect   = "Deny"
    Action   = local.deny
    Resource = "*"
  } : null

  conditional_key    = "conditional"
  conditional_exists = lookup(local.yaml_decoded, local.conditional_key, null) != null
  conditional        = regexall("\\w+:\\w+", local.conditional_exists ? yamlencode(local.yaml_decoded[local.conditional_key]) : "")

  allow_permissions = setunion(toset(local.allow), toset(local.conditional))

  merged_statement = [
    {
      Effect   = "Allow"
      Action   = local.allow_permissions
      Resource = "*"
    },
    local.deny_statement
  ]
  statement = [for entry in local.merged_statement : entry if entry != null]
}