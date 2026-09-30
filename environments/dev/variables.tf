variable "region_name" {
  description = "The aws region name"
  type = string
  default = "eu-central-1"
}

variable "project_name" {
  description = "The name of the project"
  type = string
  default = "Novapay-networking-infrastructure"
}

variable "environment" {
  description = "The name of the deployment environment"
  type = string
  default = "dev"
  validation {
    condition = contains(["dev", "prod", "staging"], var.environment)
    error_message = "The deplpyment environment must be either of these - dev, prod or staging"
  }
}