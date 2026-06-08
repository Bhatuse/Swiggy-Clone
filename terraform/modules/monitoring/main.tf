resource "aws_cloudwatch_log_group" "swiggy_logs" {
  name              = var.cw_log_group_name
  retention_in_days = var.cw_log_group_retention

  tags = {
    Environment = var.environment
    Name        = "swiggy-logs"
  }
}