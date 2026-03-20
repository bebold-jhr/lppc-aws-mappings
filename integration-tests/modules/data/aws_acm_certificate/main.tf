resource "random_uuid7" "this" {}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = "${random_uuid7.this.result}.example.com"
    organization = "Test"
  }

  validity_period_hours = 1

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
  ]
}

resource "aws_acm_certificate" "this" {
  certificate_body = tls_self_signed_cert.this.cert_pem
  private_key      = tls_private_key.this.private_key_pem
}
