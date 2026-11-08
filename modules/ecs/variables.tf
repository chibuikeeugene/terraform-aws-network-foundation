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
  type        = map(string)
  default     = {}
}

# variable "private_subnet_ids" {
#   description = "The private application subnet IDs"
#   type = list(string)
#   validation {
#     condition = length(var.private_subnet_ids) >= 2
#     error_message = "Provide at least two private subnet ids"
#   }
# }

# variable "security_group_ids" {
#   description = "The ECS tasks security group ids"
#   type = list(string)
# }

# variable "execution_role_arn" {
#   type = string
# }

# variable "task_role_arn" {
#   type = string
# }

# variable "container_image" {
#   description = "Full ECR image URI including tag or digest"
#   type = string
#   validation {
#     condition = trimspace(var.container_image) != ""
#     error_message = "ECR Image URI cannot be empty"
#   }
# }

# variable "container_port" {
#   type = number
#   default = 8000
#   validation {
#     condition = var.container_port >= 1 && var.container_port <= 65535 && floor(var.container_port) == var.container_port
#     error_message = "The container port must between 1 and 65535 and must be whole number"
#   }
# }

# variable "cpu" {
#   type = number
#   default = 256
#   nullable = false
#   validation {
#     condition = contains(
#       lookup(local.fargate_memory_by_cpu, tostring(var.cpu), []),
#       var.memory
#     )
#     error_message = "cpu and memory must form a supported Linux Fargate task size. Specify CPU in CPU units and memory in MiB."
#   }
# }

# variable "memory" {
#   type = number
#   default = 512
#   nullable = false
# }

# variable "desired_count" {
#   type = number
#   default = 2
#   validation {
#     condition = length(var.desired_count) >= 1
#     error_message = "Desired cound must be greater than 0"
#   }
# }