resource "random_uuid7" "this" {}

resource "aws_appintegrations_event_integration" "this" {
  name            = "lppc-test-${random_uuid7.this.result}"
  eventbridge_bus = "default"

  event_filter {
    source = "aws.partner/examplepartner.com"
  }
}
