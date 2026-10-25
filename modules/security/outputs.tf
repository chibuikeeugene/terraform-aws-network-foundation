output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "alb_sg_ingress_rule" {
  value = aws_security_group.alb.ingress
}