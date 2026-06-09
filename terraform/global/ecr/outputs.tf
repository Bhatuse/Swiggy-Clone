output "dev_repository_url" {
  value       = aws_ecr_repository.swiggy_app_dev.repository_url
  description = "Dev ECR repository URL"
}

output "dev_repository_arn" {
  value       = aws_ecr_repository.swiggy_app_dev.arn
  description = "Dev ECR repository ARN"
}

output "prod_repository_url" {
  value       = aws_ecr_repository.swiggy_app_prod.repository_url
  description = "Prod ECR repository URL"
}

output "prod_repository_arn" {
  value       = aws_ecr_repository.swiggy_app_prod.arn
  description = "Prod ECR repository ARN"
}
