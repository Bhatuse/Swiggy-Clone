output "dev_state_bucket" {
  value = aws_s3_bucket.dev_state.bucket
}

output "prod_state_bucket" {
  value = aws_s3_bucket.prod_state.bucket
}

output "terraform_lock_table" {
  value = aws_dynamodb_table.terraform_lock.name
}