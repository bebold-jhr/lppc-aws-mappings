data "aws_ecr_lifecycle_policy_document" "this" {
  rule {
    priority    = 1
    description = "Expire untagged images older than 14 days"

    selection {
      tag_status   = "untagged"
      count_type   = "sinceImagePushed"
      count_unit   = "days"
      count_number = 14
    }
  }
}
