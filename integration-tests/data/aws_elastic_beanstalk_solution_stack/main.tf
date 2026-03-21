data "aws_elastic_beanstalk_solution_stack" "this" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux 2023 (.*) running Docker$"
}
