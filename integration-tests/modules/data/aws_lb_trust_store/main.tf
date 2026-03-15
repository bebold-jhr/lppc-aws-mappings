resource "random_uuid" "this" {}

resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name  = "Test CA"
    organization = "Test"
  }

  validity_period_hours = 8760
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "aws_s3_bucket" "this" {
  bucket        = "${random_uuid.this.result}-ts"
  force_destroy = true
}

resource "aws_s3_object" "ca_bundle" {
  bucket  = aws_s3_bucket.this.id
  key     = "ca-bundle.pem"
  content = tls_self_signed_cert.ca.cert_pem
}

resource "aws_lb_trust_store" "this" {
  name                             = substr(random_uuid.this.result, 0, 32)
  ca_certificates_bundle_s3_bucket = aws_s3_bucket.this.id
  ca_certificates_bundle_s3_key    = aws_s3_object.ca_bundle.key
}
