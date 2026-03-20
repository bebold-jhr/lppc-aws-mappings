resource "random_uuid" "this" {}

resource "aws_vpclattice_service" "this" {
  name = "lppc-test-${substr(random_uuid.this.result, 0, 29)}"
}

resource "aws_vpclattice_listener" "this" {
  name               = "lppc-test-listener"
  protocol           = "HTTP"
  service_identifier = aws_vpclattice_service.this.id

  default_action {
    fixed_response {
      status_code = 404
    }
  }
}
