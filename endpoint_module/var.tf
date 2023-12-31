variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "link_name" {
  type = string
}

variable "pe_resource_id" {
  type = string
}

variable "subresource_name" {
  type = list(string)
}

variable "env_type" {
  type = string
  default = "nonprod"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["nonprod", "prod"], var.env_type)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
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

variable "DNS_id" {
  type = string
}

variable "DNS_zone_name" {
  type = string
}