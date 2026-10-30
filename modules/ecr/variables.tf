variable "repository_name" {
  description = "The name of the repository"
  type = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type = string
  default = "IMMUTABLE"
  validation {
    condition = contains(['MUTABLE', 'IMMUTABLE'], var.image_tag_mutability)
    error_message = "Use MUTABLE OR IMMUTABLE"
  }
}

variable "tags" {
  description = "common resource tags"
  type        = map(string)
  default     = {}
}