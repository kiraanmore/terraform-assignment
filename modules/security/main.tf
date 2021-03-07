resource "aws_kms_key" "kms-key" {
  description             = "KMS key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "kms-key-alias" {
  name          = "alias/kms-key-alias"
  target_key_id = aws_kms_key.kms-key.key_id
}