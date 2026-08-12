resource "random_uuid" "this" {}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = random_uuid.this.result
  allow_unauthenticated_identities = false
}
