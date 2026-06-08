terraform {
  backend "s3" {
    bucket         = "swiggy-terraform-state-prod"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-prod"
  }
}
