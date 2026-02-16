variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_dns_support" {
  type    = bool
  default = false
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}