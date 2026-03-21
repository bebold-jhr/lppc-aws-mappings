resource "random_uuid7" "this" {}

resource "aws_elastic_beanstalk_application" "this" {
  name = random_uuid7.this.result
}
