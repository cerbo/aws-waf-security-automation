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

resource "aws_lambda_function" "LambdaWAFLogParserFunction" {
    depends_on = ["aws_s3_bucket_object.LogParserZip"]
    function_name = "${var.customer}-LambdaWAFLogParserFunction-${element(split("-",uuid()),0)}"
    description = "This function parses CloudFront access logs to identify suspicious behavior, such as an abnormal amount of requests or errors. It then blocks those IP addresses for a customer-defined period of time."
    role = "${aws_iam_role.LambdaRoleLogParser.arn}"
    handler = "log-parser.lambda_handler"
    s3_bucket = "${aws_s3_bucket.WAFLambdaFiles.id}"
    s3_key = "log-parser.zip"
    runtime = "python2.7"
    memory_size = "512"
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
            BlacklistIPSetID = "${aws_waf_ipset.WAFBlacklistSet.id}"
            AutoBlockIPSetID = "${aws_waf_ipset.WAFAutoBlockSet.id}"
            SendAnonymousUsageData = "${var.SendAnonymousUsageData}"
            LOG_TYPE = "${var.LogType}"
            REGION = "${var.aws_region}"
            LIMIT_IP_ADDRESS_RANGES_PER_IP_MATCH_CONDITION = "${var.LimitIPAddressRangesPerIPMatchCondition}"
            MAX_AGE_TO_UPDATE = "${var.MaxAgeToUpdate}"
            UUID = "${uuid()}"
        }
    }
}
