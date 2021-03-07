data "aws_caller_identity" "current" {
}

data "aws_elb_service_account" "main" {
}

data "aws_iam_policy_document" "bucket_policy" {

    policy_id = "s3_lb_write"

    statement {
        actions = ["s3:PutObject"]
        resources = ["arn:aws:s3:::${var.log-bucket-name}/alb-logs/*"]

        principals {
            identifiers = ["${data.aws_elb_service_account.main.arn}"]
            type = "AWS"
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
        kms_master_key_id = aws_kms_key.kms-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}