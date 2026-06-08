variable "vpc_id" {
  description = "VPC ID where target groups are created"
  type        = string
}

variable "alb_security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "alb_subnets" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}