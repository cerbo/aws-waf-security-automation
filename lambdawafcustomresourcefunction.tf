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

resource "aws_lambda_function" "LambdaWAFCustomResourceFunction" {
    depends_on = ["aws_s3_bucket_object.CustomResourceZip"]
    function_name = "${var.customer}-LambdaWAFCustomResourceFunction-${element(split("-",uuid()),0)}"
    description = "This lambda function configures the Web ACL rules based on the features enabled in the CloudFormation template. Parameters: yes"
    role = "${aws_iam_role.LambdaRoleCustomResource.arn}"
    handler = "custom-resource.lambda_handler"
    s3_bucket = "${var.customer}-waflambdafiles"
    s3_key = "custom-resource.zip"
    runtime = "python2.7"
    memory_size = "128"
    timeout = "300"
    environment {
        variables = {
            CloudFrontAccessLogBucket = "${var.CloudFrontAccessLogBucket}"
            ActivateBadBotProtectionParam = "${var.ActivateBadBotProtectionParam}"
            ActivateHttpFloodProtectionParam = "${var.ActivateHttpFloodProtectionParam}"
            ActivateReputationListsProtectionParam = "${var.ActivateReputationListsProtectionParam}"
            ActivateScansProbesProtectionParam = "${var.ActivateScansProbesProtectionParam}"
            CrossSiteScriptingProtectionParam = "${var.CrossSiteScriptingProtectionParam}"
            SqlInjectionProtectionParam = "${var.SqlInjectionProtectionParam}"
            ErrorThreshold = "${var.ErrorThreshold}"
            RequestThreshold = "${var.RequestThreshold}"
            WAFBlockPeriod = "${var.WAFBlockPeriod}"
            SendAnonymousUsageData = "${var.SendAnonymousUsageData}"
        }
    }
}

