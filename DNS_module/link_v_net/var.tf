variable "vnet_id" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "DNS_name" {
  type = string
}

variable "env" {
  type = string
  default = "dev"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "auto_registration" {
  type = bool
}
