variable "aws_account_id" {
  type = string

  validation {
    condition     = can(regex("^\\d{12}$", var.aws_account_id))
    error_message = "Invalid AWS account ID."
  }
}

variable "address_line_1" {
  type = string
}

variable "city" {
  type = string
}

variable "company_name" {
  type = string
}

variable "phone_number" {
  type = string
}

variable "postal_code" {
  type = string
}

variable "state_or_region" {
  type = string
}

variable "website_url" {
  type = string
}