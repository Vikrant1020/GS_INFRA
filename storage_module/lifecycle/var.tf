variable "rule_enable" {
  type = bool
}

variable "storage_account_id" {
  type = string
}

variable "container_name" {
  type = string
}

variable "time_to_move_to_archive" {
  type = number
}

variable "time_to_move_to_cool" {
  type = number
}

variable "lifecyle_rule_name" {
  type = string
}