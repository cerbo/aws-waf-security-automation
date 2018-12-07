provider "aws" {
  region  = "us-east-1"
  profile = "devops"
}

resource "aws_kinesis_firehose_delivery_stream" "aws-waf-logs-devops" {
  name        = "${var.waf_kinesis_name}"
  destination = "splunk"

  s3_configuration {
    role_arn        = "${aws_iam_role.waf_kinesis_firehose_role.arn}"
    bucket_arn      = "${aws_s3_bucket.waf_kinesis_bucket.arn}"
    buffer_size     = "5"                                             #5 megabytes
    buffer_interval = "300"                                           #300 seconds
  }

  splunk_configuration {
    hec_endpoint               = "${var.splunk_hec_endpoint}"
    hec_token                  = "${var.splunk_hec_token}"
    hec_acknowledgment_timeout = 180
    hec_endpoint_type          = "Raw"
    s3_backup_mode             = "FailedEventsOnly"
  }
}
