variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The name of the deployment environment"
  type        = string
}

variable "tags" {
  description = "common resource tags"
  type = map(string)
  default = {}
}