resource "random_uuid7" "this" {}

resource "aws_batch_scheduling_policy" "this" {
  name = "${random_uuid7.this.result}-rg"

  fair_share_policy {
    compute_reservation = 1
    share_decay_seconds = 3600

    share_distribution {
      share_identifier = "A1*"
      weight_factor    = 0.1
    }
  }
}
