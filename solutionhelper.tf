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

resource "aws_lambda_function" "SolutionHelper" {
    depends_on = ["aws_s3_bucket_object.SolutionHelperZip"]
    function_name = "${var.customer}-SolutionHelper-${element(split("-",uuid()),0)}"
    description = "This lambda function executes generic common tasks to support this solution."
    role = "${aws_iam_role.SolutionHelperRole.arn}"
    handler = "log-parser.lambda_handler"
    #s3_bucket = "solutions-${var.aws_region}"
    #s3_key = "library/solution-helper/v1/solution-helper.zip"
    s3_bucket = "${var.customer}-waflambdafiles"
    s3_key = "solution-helper.zip"
    runtime = "python2.7"
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
