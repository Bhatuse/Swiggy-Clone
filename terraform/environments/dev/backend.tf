terraform {
  backend "s3" {
    bucket = "swiggy-tfstate-dev"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}