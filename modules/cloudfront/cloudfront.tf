resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${var.bucket_name}.s3-website.${var.region}.amazonaws.com"
    origin_id   = "S3-Website-${var.bucket_name}.s3-website.${var.region}.amazonaws.com"

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_protocol_policy   = "${var.origin_protocol_policy}"
      origin_ssl_protocols     = "${var.origin_ssl_protocols}"
      origin_keepalive_timeout = "${var.origin_keepalive_timeout}"
      origin_read_timeout      = "${var.origin_read_timeout}"
    }
  }

  enabled             = "${var.enabled}"
  is_ipv6_enabled     = "${var.ipv6_enabled}"
  comment             = "${var.comment}"
  default_root_object = "${var.root_object}"
  price_class         = "${var.price_class}"

  logging_config {
    include_cookies = "${var.log_include_cookies}"
    bucket          = "${var.logging_bucket}"
    prefix          = "${var.logging_bucket_prefix}"
  }

  aliases = ["${var.bucket_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Website-${var.bucket_name}.s3-website.${var.region}.amazonaws.com"

    forwarded_values {
      query_string = "${var.query_string}"
      headers      = ["Accept", "Access-Control-Request-Headers", "Access-Control-Request-Method", "Authorization", "Host", "Origin", "Referer", "X-Page-Limit", "X-Page-Page", "X-Page-Total"]

      cookies {
        forward = "${var.cookies}"
      }
    }

    compress               = true
    viewer_protocol_policy = "${var.viewer_protocol_policy}"
    min_ttl                = "${var.min_ttl}"
    default_ttl            = "${var.default_ttl}"
    max_ttl                = "${var.max_ttl}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "${var.env}"
  }

  viewer_certificate {
    acm_certificate_arn      = "${var.certificate_arn}"
    ssl_support_method       = "${var.ssl_support_method}"
    minimum_protocol_version = "${var.protocol_version}"
  }
}
