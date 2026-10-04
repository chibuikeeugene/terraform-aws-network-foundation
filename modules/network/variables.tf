variable "vpc_cidr_block" {
  description = "The CIDR block for Novapay VPC"
  type = string
  validation {
    condition = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "The value must be a valid cidr block"
  }
}

variable "tags" {
  description = "additional tags assigned to module resouces"
  type = map(string)
  default = {}
}

variable "name_prefix" {
  description = "The prefix attached to each Novapay resource name"
  type = string
  validation {
    condition = length(trimspace(var.name_prefix))>3
    error_message = "The lenght of the prefix must be greater than three at least"
  }
}

variable "public_subnets" {
  description = "The public subnets to create"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_subnets_app" {
  description = "The private subnets of the application to create"
  type = map(object({
    cidr = string
    availability_zone = string
  }))
}

variable "private_subnets_db" {
  description = "The private subnets of the database to create"
  type = map(object({
    cidr = string
    availability_zone = string
  }))
}