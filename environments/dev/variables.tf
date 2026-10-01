variable "region_name" {
  description = "The aws region name"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "Novapay-networking-infrastructure"
}

variable "environment" {
  description = "The name of the deployment environment"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "The deplpyment environment must be either of these - dev, prod or staging"
  }
}

variable "vpc_cidr_block" {
  description = "The CIDR block for Novapay VPC"
  type        = string
  default     = "10.20.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "The value must be a valid cidr block"
  }
}

variable "public_subnets" {
  description = "The public subnets to create"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "The private subnets to create"
  type = map(object({
    cidr = string
    availability_zone = string
  }))
}