resource "aws_s3_bucket" "s3_bucket_media" {
  bucket = "cs-s3-${var.environment}-media"
  acl    = "private"
  versioning {
    enabled = false
  }
  tags = {
    Name      = "cs-s3-${var.environment}-media"
    CreatedBy = "Terraform"
  }
}