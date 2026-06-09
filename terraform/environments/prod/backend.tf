terraform {
  backend "s3" {
    bucket = "swiggy-tfstate-prod"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}