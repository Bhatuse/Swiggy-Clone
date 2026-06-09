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