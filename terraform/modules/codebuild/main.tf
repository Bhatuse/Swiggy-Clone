resource "aws_codebuild_project" "this" {
  name          = "${var.project_name}-${var.environment}-build"
  service_role  = var.codebuild_role_arn
  build_timeout = 30

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true    # required for docker build/push

    environment_variable {
      name  = "ECR_REPO_URI"
      value = var.ecr_repo_uri
    }
    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/codebuild/${var.project_name}-${var.environment}"
    }
  }

  tags = { Environment = var.environment }
}