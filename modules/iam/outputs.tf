output "ecs_task_execution_arn" {
  description = "ECS task execution role ARN"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_arn" {
  description = "ECS application task role ARN"
  value       = aws_iam_role.ecs_task.arn
}