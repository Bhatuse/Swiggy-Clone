output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.blue_green_repo.name
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.blue_green_repo.arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.blue_green_repo.repository_url
}