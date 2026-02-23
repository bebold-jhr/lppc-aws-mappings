variable "aws_account_id" {
  type = string

  validation {
    condition     = can(regex("^\\d{12}$", var.aws_account_id))
    error_message = "Invalid AWS account ID."
  }
}

variable "test_email" {
  type = string
}

variable "test_phone_number" {
  type = string
}