resource "aws_s3_bucket" "dev_state" {
  bucket = "swiggy-tfstate-dev-pravin"

  tags = {
    Name        = "swiggy-tfstate-dev"
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "prod_state" {
  bucket = "swiggy-tfstate-prod-pravin"

  tags = {
    Name        = "swiggy-tfstate-prod"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_versioning" "dev_state" {
  bucket = aws_s3_bucket.dev_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "prod_state" {
  bucket = aws_s3_bucket.prod_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev_state" {
  bucket = aws_s3_bucket.dev_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "prod_state" {
  bucket = aws_s3_bucket.prod_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "dev_state" {
  bucket = aws_s3_bucket.dev_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod_state" {
  bucket = aws_s3_bucket.prod_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-lock"
  }
}