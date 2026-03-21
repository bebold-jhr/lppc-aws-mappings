data "aws_appstream_image" "this" {
  type        = "PUBLIC"
  most_recent = true
  name_regex  = "^AppStream-WinServer.*"
}
