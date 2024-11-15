resource "aws_s3_bucket" "deploy_bucket" {
  bucket        = var.name
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.deploy_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.deploy_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.deploy_bucket.id
  acl    = "public-read"
}

locals {
  policy_content  = file(var.policy_file)
  replaced_policy = replace(local.policy_content, "BUCKET_ARN", aws_s3_bucket.deploy_bucket.arn)
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.deploy_bucket.id
  policy = local.replaced_policy

  depends_on = [aws_s3_bucket_acl.example]
}

resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = aws_s3_bucket.deploy_bucket.id
  index_document {
    suffix = "index.html"
  }
}