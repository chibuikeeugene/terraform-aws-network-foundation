output "repository_url" {
  description = "The ECR Repository URL"
  value = aws_ecr_repository.payment_api.repository_url
}

output "repository_arn" {
  description = "The ECR Repository ARN"
  value = aws_ecr_repository.payment_api.arn
}

output "repository_name" {
  description = "The name of the ECR repository"
  value = aws_ecr_repository.payment_api.name
}