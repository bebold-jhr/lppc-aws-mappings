resource "aws_devopsguru_resource_collection" "this" {
  type = "AWS_TAGS"

  tags {
    app_boundary_key = "DevOps-Guru-lppc-test"
    tag_values       = ["lppc-integration-test"]
  }
}
