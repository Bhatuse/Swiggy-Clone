output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  description = "ECS Security Group ID"
  value       = aws_security_group.ecs_sg.id
}

output "sonar_sg_id" {
  description = "SonarQube Security Group ID"
  value       = aws_security_group.sonar_sg.id
}