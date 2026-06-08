terraform {
  required_version = ">= 1.0"
}

module "networking" {
  source = "../../modules/networking"

  environment              = var.environment
  vpc_cidr                 = var.vpc_cidr
  private_subnet_1_cidr    = var.private_subnet_1_cidr
  private_subnet_2_cidr    = var.private_subnet_2_cidr
  public_subnet_1_cidr     = var.public_subnet_1_cidr
  public_subnet_2_cidr     = var.public_subnet_2_cidr
  availability_zones       = var.availability_zones
}

module "security" {
  source = "../../modules/security"

  vpc_id = module.networking.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  vpc_id               = module.networking.vpc_id
  alb_security_groups  = [module.security.alb_security_group_id]
  alb_subnets          = module.networking.public_subnet_ids
}

module "monitoring" {
  source = "../../modules/monitoring"

  environment               = var.environment
  cw_log_group_name         = var.cw_log_group_name
  cw_log_group_retention    = var.cw_log_group_retention
}

module "ecr" {
  source = "../../global/ecr"

  ecr_repo_name = var.ecr_repo_name
}

module "ecs" {
  source = "../../global/ecs"

  aws_region           = var.aws_region
  ecr_repository_url   = module.ecr.ecr_repository_url
  log_group_name       = module.monitoring.cw_log_group_name
}
