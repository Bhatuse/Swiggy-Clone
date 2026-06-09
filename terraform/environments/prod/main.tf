module "networking" {
  source               = "../../modules/networking"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.networking.vpc_id
}

module "iam" {
  source = "../../modules/iam"
}

module "alb" {
  source            = "../../modules/alb"
  vpc_id            = module.networking.vpc_id
  alb_sg_id         = module.security_groups.alb_sg_id
  public_subnet_ids = module.networking.public_subnet_ids
}

module "ecs" {
  source                 = "../../modules/ecs"
  private_subnet_ids     = module.networking.private_subnet_ids
  ecs_sg_id              = module.security_groups.ecs_sg_id
  blue_target_group_arn  = module.alb.blue_target_group_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  image_uri              = var.container_image_uri
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.s3_bucket_name
  environment = var.environment
}

module "sonarqube" {
  source           = "../../modules/sonarqube"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  public_subnet_id = module.networking.public_subnet_ids[0]
  sonar_sg_id      = module.security_groups.sonar_sg_id
  key_name         = var.key_name
}

module "codedeploy" {
  source             = "../../modules/codedeploy"
  project_name       = var.project_name
  environment        = var.environment
  codedeploy_role_arn = module.iam.codedeploy_role_arn
  ecs_cluster_name   = module.ecs.cluster_name
  ecs_service_name   = module.ecs.service_name
  prod_listener_arn  = module.alb.prod_listener_arn   # :80
  test_listener_arn  = module.alb.test_listener_arn   # :8080
  blue_tg_name       = module.alb.blue_tg_name
  green_tg_name      = module.alb.green_tg_name
}

module "codebuild" {
  source              = "../../modules/codebuild"
  project_name        = var.project_name
  environment         = var.environment
  codebuild_role_arn  = module.iam.codebuild_role_arn
  ecr_repo_uri        = module.ecr.repository_url      # from your existing ECR module
  aws_region          = var.aws_region
}

module "codepipeline" {
  source                  = "../../modules/codepipeline"
  project_name            = var.project_name
  environment             = var.environment
  codepipeline_role_arn   = module.iam.codepipeline_role_arn
  artifact_bucket         = module.s3.artifact_bucket_name
  codestar_connection_arn = var.codestar_connection_arn
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  codebuild_project_name  = module.codebuild.project_name
  codedeploy_app_name     = module.codedeploy.app_name
  codedeploy_dg_name      = module.codedeploy.deployment_group_name
}