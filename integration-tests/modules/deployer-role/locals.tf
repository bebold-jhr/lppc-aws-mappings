locals {
  block_type         = basename(abspath("${path.cwd}/.."))
  resource_type      = basename(path.cwd)
  mappings_file_path = fileexists("../../../mappings/${local.block_type}/${local.resource_type}.yml") ? "../../../mappings/${local.block_type}/${local.resource_type}.yml" : "./placeholder-for-validation.yml"
  mappings_file      = abspath(local.mappings_file_path)
  actions            = yamldecode(file(local.mappings_file)).actions
}