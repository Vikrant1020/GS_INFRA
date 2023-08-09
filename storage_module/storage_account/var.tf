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

variable "rg_location" {
    type = string  
}

variable "rg_name" {
    type = string
}