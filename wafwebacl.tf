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

resource "aws_waf_web_acl" "WAFWebACL" {
    depends_on = ["aws_waf_rule.WAFWhitelistRule", "aws_waf_rule.WAFBlacklistRule", "aws_waf_rule.WAFAutoBlockRule", "aws_waf_rule.WAFIPReputationListsRule1", "aws_waf_rule.WAFIPReputationListsRule2", "aws_waf_rule.WAFBadBotRule", "aws_waf_rule.WAFSqlInjectionRule", "aws_waf_rule.WAFXssRule"]
    name = "${var.customer}"
    metric_name = "SecurityAutomationsMaliciousRequesters"
    default_action {
        type = "ALLOW"
    }
    rules {
        action {
            type = "ALLOW"
        }
        priority = 10
        rule_id = "${aws_waf_rule.WAFWhitelistRule.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 20
        rule_id = "${aws_waf_rule.WAFBlacklistRule.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 30
        rule_id = "${aws_waf_rule.WAFAutoBlockRule.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 40
        rule_id = "${aws_waf_rule.WAFIPReputationListsRule1.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 50
        rule_id = "${aws_waf_rule.WAFIPReputationListsRule2.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 60
        rule_id = "${aws_waf_rule.WAFBadBotRule.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 70
        rule_id = "${aws_waf_rule.WAFSqlInjectionRule.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 80
        rule_id = "${aws_waf_rule.WAFXssRule.id}"
    }
}
