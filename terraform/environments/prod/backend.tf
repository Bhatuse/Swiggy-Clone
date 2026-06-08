terraform {
  backend "s3" {
    bucket = "swiggy-tfstate"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}