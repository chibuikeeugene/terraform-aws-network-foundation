variable "region_name" {
  description = "The aws region for terraform remote state backend"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "terraform-state-backend"
}