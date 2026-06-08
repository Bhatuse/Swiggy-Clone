terraform {
  backend "s3" {
    bucket         = "swiggy-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-dev"
  }
}
