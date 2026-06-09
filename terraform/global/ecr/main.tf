resource "aws_ecr_repository" "swiggy_app_dev" {
  name                 = "swiggy-app-dev"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "swiggy-app-dev"
    Environment = "dev"
  }
}

resource "aws_ecr_repository" "swiggy_app_prod" {
  name                 = "swiggy-app-prod"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "swiggy-app-prod"
    Environment = "prod"
  }
}

resource "aws_ecr_lifecycle_policy" "swiggy_app_dev" {
  repository = aws_ecr_repository.swiggy_app_dev.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "swiggy_app_prod" {
  repository = aws_ecr_repository.swiggy_app_prod.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
