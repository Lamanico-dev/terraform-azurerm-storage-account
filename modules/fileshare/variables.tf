variable "name" {}

variable "storage_account_name" {
  type = string
}

variable "quota" {}

variable "access_tier" {
  type    = string
  default = "Hot"
}
