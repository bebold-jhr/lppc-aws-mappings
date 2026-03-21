resource "random_uuid7" "this" {}

resource "aws_wafv2_regex_pattern_set" "this" {
  name  = random_uuid7.this.result
  scope = "REGIONAL"

  regular_expression {
    regex_string = "^test.*$"
  }
}
