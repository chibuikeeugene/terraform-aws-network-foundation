output "alb_sg_id" {
  description = "Application Load Balancer Security group ID"
  value       = aws_security_group.alb.id
}


output "ecs_app_sg_id" {
  description = "ECS App security group ID"
  value       = aws_security_group.app.id
}


output "database_sg_id" {
  description = "Database security group ID"
  value       = aws_security_group.database.id
}