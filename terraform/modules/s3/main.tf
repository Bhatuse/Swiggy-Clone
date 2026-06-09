resource "aws_s3_bucket" "alb_logs" {
  bucket = var.bucket_name

  tags = {
    Name        = "alb-logs"
    Environment = var.environment
  }
}