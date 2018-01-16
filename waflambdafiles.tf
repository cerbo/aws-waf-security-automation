###############################################################################
#   Copyright 2016 Cerbo.IO, LLC.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
###############################################################################


resource "random_string" "lambda_bucket" {
  length  = 8
  special = false
}

resource "aws_s3_bucket" "WAFLambdaFiles" {
  bucket = "waflambdafiles-${random_string.lambda_bucket.result}"
  acl    = "private"

  tags {
    Name        = "WAF Lambda Files"
    Environment = "Production"
  }
}
resource "aws_s3_bucket_object" "LogParserZip" {
    depends_on = ["aws_s3_bucket.WAFLambdaFiles"]
    bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    key = "log-parser.zip"
    source = "${path.module}/files/log-parser/log-parser.zip"
    etag = "${md5(file("${path.module}/files/log-parser/log-parser.zip"))}"
}
resource "aws_s3_bucket_object" "CustomResourceZip" {
    depends_on = ["aws_s3_bucket.WAFLambdaFiles"]
    bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    key = "custom-resource.zip"
    source = "${path.module}/files/custom-resource/custom-resource.zip"
    etag = "${md5(file("${path.module}/files/custom-resource/custom-resource.zip"))}"
}
resource "aws_s3_bucket_object" "AccessHandlerZip" {
    depends_on = ["aws_s3_bucket.WAFLambdaFiles"]
    bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    key = "access-handler.zip"
    source = "${path.module}/files/access-handler/access-handler.zip"
    etag = "${md5(file("${path.module}/files/access-handler/access-handler.zip"))}"
}
resource "aws_s3_bucket_object" "ReputationListsParserZip" {
    depends_on = ["aws_s3_bucket.WAFLambdaFiles"]
    bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    key = "reputation-lists-parser.zip"
    source = "${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"
    etag = "${md5(file("${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"))}"
}
resource "aws_s3_bucket_object" "SolutionHelperZip" {
    depends_on = ["aws_s3_bucket.WAFLambdaFiles"]
    bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    key = "solution-helper.zip"
    source = "${path.module}/files/solution-helper/solution-helper.zip"
    etag = "${md5(file("${path.module}/files/solution-helper/solution-helper.zip"))}"
}
