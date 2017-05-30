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

resource "aws_lambda_permission" "LambdaInvokePermissionReputationListsParser" {
    #depends_on = ["aws_lambda_function.LambdaWAFReputationListsParserFunction", "aws_cloudwatch_event_rule.LambdaWAFReputationListsParserEventsRule"]
    function_name = "${aws_lambda_function.LambdaWAFReputationListsParserFunction.arn}"
    action = "lambda:InvokeFunction"
    principal = "events.amazonaws.com"
    statement_id = "AllowExecutionFromCloudWatch"
    source_arn = "${aws_cloudwatch_event_rule.LambdaWAFReputationListsParserEventsRule.arn}"
    #source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.ApiGatewayBadBot.id}/*/${aws_api_gateway_method.ApiGatewayBadBotMethod.http_method}/"
}
