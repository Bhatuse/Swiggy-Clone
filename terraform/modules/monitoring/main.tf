resource "aws_cloudwatch_log_group" "swiggy_logs" {
  name = "/ecs/swiggy"

  retention_in_days = 7
}