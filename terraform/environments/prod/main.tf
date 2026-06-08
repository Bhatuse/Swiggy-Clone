module "networking" {
  source              = "../../modules/networking"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "ecs" {
  source       = "../../modules/ecs"
  cluster_name = "${var.project_name}-${var.environment}"
  subnet_ids   = module.networking.subnet_ids
  tg_arn       = module.alb.blue_tg_arn
  role_arn     = module.iam.ecs_execution_role_arn
}