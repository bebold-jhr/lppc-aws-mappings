data "aws_ce_tags" "this" {
  time_period {
    start = "2024-01-01"
    end   = "2024-02-01"
  }
}
