resource "random_uuid7" "this" {}

resource "aws_codeguruprofiler_profiling_group" "this" {
  name             = "lppc-test-${random_uuid7.this.result}"
  compute_platform = "Default"

  agent_orchestration_config {
    profiling_enabled = true
  }
}
