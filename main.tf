resource "aws_s3_bucket" "bucket_primary" {
  bucket = "${var.project_name}-primary"
  #region = var.aws_region_primary

  tags = {
    Name = "${var.project_name}-primary-${var.aws_region_primary}"
  }
}

resource "aws_s3_bucket" "bucket_secondary" {
  bucket   = "${var.project_name}-secondary"
  provider = aws.ohio

  tags = {
    Name = "${var.project_name}-secondary-${var.aws_region_secondary}"
  }
}

resource "aws_s3_bucket_object" "object_bucket_primary" {
  bucket = "${var.project_name}-primary"
  key    = "Pratham_CloudInfra_6.5yrs.pdf"
  source = "Pratham_CloudInfra_6.5yrs.pdf"
  etag = filemd5("Pratham_CloudInfra_6.5yrs.pdf")
}

/*
## Upload the file manually as we are getting 403 error due to different region
*******************************************************************************
resource "aws_s3_bucket_object" "object_bucket_secondary" {
  bucket = "${var.project_name}-secondary"
  key    = "Pratham_CloudInfra_6.5yrs.pdf"
  source = "Pratham_CloudInfra_6.5yrs.pdf"
  etag = filemd5("Pratham_CloudInfra_6.5yrs.pdf")
}
*/

locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_origin_access_control" "example" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket_primary.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }
  enabled             = true
  default_cache_behavior {
    # Using the CachingDisabled managed policy ID:
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    path_pattern     = "/content/*"
    target_origin_id = local.s3_origin_id
  }

    restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

    viewer_certificate {
    cloudfront_default_certificate = true
  }

 default_root_object = "Pratham_CloudInfra_6.5yrs.pdf"

}


# pushed to dev branch

#Pushed to the main branch












