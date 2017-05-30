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

resource "aws_api_gateway_rest_api" "ApiGatewayBadBot" {
    name = "${var.customer} - Security Automations - WAF Bad Bot API"
    description = "API created by AWS WAF Security Automations CloudFormation template. This endpoint will be used to capture bad bots."
}

resource "aws_api_gateway_resource" "ApiGatewayBadBotResource" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayBadBot.id}"
    parent_id = "${aws_api_gateway_rest_api.ApiGatewayBadBot.root_resource_id}"
    path_part = "waf"
}
