resource "random_uuid7" "this" {}

resource "aws_backup_framework" "this" {
  name = "lppc_test_${replace(random_uuid7.this.result, "-", "_")}"

  control {
    name = "BACKUP_PLAN_MIN_FREQUENCY_AND_MIN_RETENTION_CHECK"

    input_parameter {
      name  = "requiredFrequencyUnit"
      value = "hours"
    }

    input_parameter {
      name  = "requiredFrequencyValue"
      value = "24"
    }

    input_parameter {
      name  = "requiredRetentionDays"
      value = "35"
    }
  }
}
