output "bucket_id" {
  value       = aws_s3_bucket.alb_logs.id
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.alb_logs.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.alb_logs.id
  description = "The name of the S3 bucket"
}

