variable "cw_log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "/ecs/swiggy"
}

variable "cw_log_group_retention" {
  description = "Retention period (in days) for CloudWatch logs"
  type        = number
  default     = 7
}