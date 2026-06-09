variable "project_name" {
  type        = string
  description = "Project name for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for subnets"
}

variable "container_image_uri" {
  type        = string
  description = "Docker image URI for ECS task"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for SonarQube instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for SonarQube"
  default     = "t3.medium"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name for SonarQube instance"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for ALB logs"
}

variable "ecr_repo_uri" {
  type = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "codestar_connection_arn" {
  description = "CodeStar Connection ARN"
  type        = string
}

variable "github_repo" {
  description = "GitHub Repository"
  type        = string
}

variable "github_branch" {
  description = "GitHub Branch"
  type        = string
}