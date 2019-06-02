resource "aws_s3_bucket" "info" {
  bucket        = "${var.info_bucket}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
}

resource "aws_s3_bucket" "assets" {
  bucket        = "${var.asset_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "elb_logs" {
  bucket        = "${var.elb_logs}"
  force_destroy = true
}

resource "aws_s3_bucket" "iptun" {
  bucket        = "${var.iptun_bucket}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
}

resource "aws_s3_bucket" "cloudfront" {
  bucket        = "${var.cloudfront}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
}


resource "aws_s3_bucket" "manage" {
  bucket        = "${var.manage}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
  
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
	"Condition": {
		"KeyPrefixEquals": "verify"
	},
	"Redirect": {
	    "Protocol": "https",
		"HostName": "manage.${var.env}.${var.domain}",
		"ReplaceKeyPrefixWith": "signin.html#!verify"
	}
},
{
	"Condition": {
		"KeyPrefixEquals": "suppport"
	},
	"Redirect": {
	    "Protocol": "https",
		"HostName": "manage.${var.env}.${var.domain}",
		"ReplaceKeyPrefixWith": "signin.html#!support"
	}
},
{
	"Condition": {
		"KeyPrefixEquals": "claim"
	},
	"Redirect": {
	    "Protocol": "https",
		"HostName": "manage.${var.env}.${var.domain}",
		"ReplaceKeyPrefixWith": "signin.html#!claim"
	}
}]
EOF
  }
}


resource "aws_s3_bucket" "cloudfront_status" {
  bucket        = "${var.cloudfront_status}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
}

resource "aws_s3_bucket" "status" {
  bucket        = "${var.status}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
      }
    }
  }
  force_destroy = true
    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_origins = ["https://manage.${var.domain}","https://manage.${var.env}.${var.domain}","https://integration.${var.domain}","https://dev-ui.${var.domain}","https://dev.${var.domain}","https://admin.${var.domain}","https://speedtest.${var.domain}","https://demo.${var.domain}"]
    expose_headers  = ["ETag"]
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "ap-logs" {
  bucket        = "${var.ap_logs_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "papi" {
  bucket        = "${var.papi_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "kafka-backup-bucket-1" {
  bucket        = "${var.kafka1_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "kafka-backup-bucket-2" {
  bucket        = "${var.kafka2_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "exhibitor" {
  bucket        = "${var.exhibitor_bucket}"
  force_destroy = true
}


resource "aws_s3_bucket" "kafka-backup-bucket" {
  bucket        = "${var.kafka_bucket}"
  force_destroy = true
}

resource "aws_s3_bucket" "kafka-reseed-bucket" {
  bucket        = "${var.kafka_reseed_bucket}"
  force_destroy = true
}



