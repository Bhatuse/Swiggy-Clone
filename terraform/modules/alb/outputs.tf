output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.swiggy_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.swiggy_alb.arn
}

output "alb_target_group_blue_arn" {
  description = "ARN of the Blue target group"
  value       = aws_lb_target_group.alb_tg_blue.arn
}

output "alb_target_group_green_arn" {
  description = "ARN of the Green target group"
  value       = aws_lb_target_group.alb_tg_green.arn
}

output "alb_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http_listener.arn
}
