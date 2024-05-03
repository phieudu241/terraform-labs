terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

variable "project_name" {
  type = string
}

resource "aws_s3_bucket" "my_project" {
  bucket = "${var.project_name}-bucket"

  tags = {
    Name        = var.project_name
    Environment = "dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "my_project" {
  bucket = aws_s3_bucket.my_project.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "my_project" {
  bucket = aws_s3_bucket.my_project.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "my_project" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my_project,
    aws_s3_bucket_public_access_block.my_project,
  ]

  bucket = aws_s3_bucket.my_project.id
  acl    = "public-read"
}
