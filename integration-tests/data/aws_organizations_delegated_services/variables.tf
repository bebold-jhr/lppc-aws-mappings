variable "delegated_admin_account_id" {
  type = string

  validation {
    condition     = can(regex("^\\d{12}$", var.delegated_admin_account_id))
    error_message = "Invalid AWS account ID."
  }
}