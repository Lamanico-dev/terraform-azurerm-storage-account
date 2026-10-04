variable "name" {
  type = string
}

variable "storage_account_id" {
  type = string
}

variable "quota" {
  type = number
}

variable "access_tier" {
  type    = string
  default = "Hot"
}
