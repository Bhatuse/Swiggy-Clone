output "sonarqube_security_group_id" {
  description = "ID of the SonarQube security group"
  value       = aws_security_group.sonarqube_sg.id
}

output "sonarqube_security_group_arn" {
  description = "ARN of the SonarQube security group"
  value       = aws_security_group.sonarqube_sg.arn
}
