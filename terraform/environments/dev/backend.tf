terraform {
  backend "s3" {
    bucket = "swiggy-tfstate"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}