data "aws_caller_identity" "current" {
}

data "aws_elb_service_account" "main" {
}

data "aws_iam_policy_document" "bucket_policy" {

    statement {
    sid    = "alb-logs-put-object"
    actions   = ["s3:PutObject"]
    resources = [
      "arn:aws:s3:::${var.log-bucket-name}/alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.log-bucket-name}"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.main.id}:root"]
    }
  }

    statement {
    sid    = "alb-logs-put-object-2"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.log-bucket-name}/alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test = "StringEquals"
      values = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }

  statement {
    sid    = "alb-logs-get-acl"
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.log-bucket-name}"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket" "log-bucket" {
  bucket = var.log-bucket-name
  acl    = "private"
  policy        = data.aws_iam_policy_document.bucket_policy.json
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}