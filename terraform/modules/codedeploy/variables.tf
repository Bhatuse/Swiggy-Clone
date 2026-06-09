variable "project_name"        {}
variable "environment"         {}
variable "codedeploy_role_arn" {}
variable "ecs_cluster_name"    {}
variable "ecs_service_name"    {}
variable "prod_listener_arn"   {}   # ALB :80
variable "test_listener_arn"   {}   # ALB :8080
variable "blue_tg_name"        {}
variable "green_tg_name"       {}