terraform {
  backend "s3" {
    bucket = "swiggy-tfstate-prod-pravin"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}