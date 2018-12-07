resource "aws_s3_bucket" "waf_kinesis_bucket" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"

  logging {
    target_bucket = "${var.logging_bucket_name}"
    target_prefix = "s3logs"
  }
}
