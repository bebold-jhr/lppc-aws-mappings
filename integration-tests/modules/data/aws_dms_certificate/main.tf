resource "random_uuid7" "this" {}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name = "lppc-test"
  }

  validity_period_hours = 24

  allowed_uses = [
    "digital_signature",
  ]
}

resource "aws_dms_certificate" "this" {
  certificate_id  = "lppc-test-${random_uuid7.this.result}"
  certificate_pem = tls_self_signed_cert.this.cert_pem
}
