variable "vpc_cidr_block" {
  type = string
}

variable "cidr_block_public_1" {
  type = string
}

variable "cidr_block_public_2" {
  type = string
}

variable "cidr_block_private_1" {
  type = string
}

variable "project" {
  type = string
  default = "shimodaira"
}

variable "enviroment" {
  type = string
  default = "env"
}

variable "az_1a" {
  type = string
}

variable "az_1c" {
  type = string
}

