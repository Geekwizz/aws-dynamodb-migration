resource "aws_s3_bucket" "migration_data_bucket" {
  bucket = "${var.s3_bucket_name}-${data.aws_caller_identity.current.account_id}"
  tags = merge(var.tags, { Name = var.s3_bucket_name })
}

resource "aws_s3_bucket_versioning" "migration_data_versioning" {
  bucket = aws_s3_bucket.migration_data_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "migration_data_encryption" {
  bucket = aws_s3_bucket.migration_data_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "migration_data_pab" {
  bucket = aws_s3_bucket.migration_data_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_caller_identity" "current" {}