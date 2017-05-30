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

resource "aws_cloudwatch_event_rule" "LambdaWAFReputationListsParserEventsRule" {
    depends_on = ["aws_lambda_function.LambdaWAFReputationListsParserFunction", "aws_waf_ipset.WAFReputationListsSet1", "aws_waf_ipset.WAFReputationListsSet2"]
    name = "${var.customer}-LambdaWAFReputationListsParserEventsRule-${element(split("-",uuid()),0)}"
    description = "Security Automations - WAF Reputation Lists"
    schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "LambdaWAFReputationListsParserEventsRuleTarget" {
    depends_on = ["aws_cloudwatch_event_rule.LambdaWAFReputationListsParserEventsRule"]
    rule = "${aws_cloudwatch_event_rule.LambdaWAFReputationListsParserEventsRule.name}"
    target_id = "${aws_lambda_function.LambdaWAFReputationListsParserFunction.id}"
    arn = "${aws_lambda_function.LambdaWAFReputationListsParserFunction.arn}"
    input = "{\"lists\":[{\"url\":\"https://www.spamhaus.org/drop/drop.txt\"},{\"url\":\"https://check.torproject.org/exit-addresses\",\"prefix\":\"ExitAddress \"},{\"url\":\"https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt\"}],\"ipSetIds\": [\"${aws_waf_ipset.WAFReputationListsSet1.id}\",\"${aws_waf_ipset.WAFReputationListsSet2.id}\"]}"
}
