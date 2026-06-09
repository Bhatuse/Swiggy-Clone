output "alb_id" {
  description = "Application Load Balancer ID"
  value       = aws_lb.swiggy_alb.id
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.swiggy_alb.arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.swiggy_alb.dns_name
}

output "alb_zone_id" {
  description = "Application Load Balancer Hosted Zone ID"
  value       = aws_lb.swiggy_alb.zone_id
}

output "blue_target_group_arn" {
  value = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  value = aws_lb_target_group.green.arn
}

output "prod_listener_arn" {
  value = aws_lb_listener.prod.arn
}

output "test_listener_arn" {
  value = aws_lb_listener.test.arn
}

output "blue_tg_name" {
  value = aws_lb_target_group.blue.name
}

output "green_tg_name" {
  value = aws_lb_target_group.green.name
}