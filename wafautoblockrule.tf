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

resource "aws_waf_rule" "WAFAutoBlockRule" {
    depends_on = ["aws_waf_ipset.WAFAutoBlockSet"]
    name = "${var.customer} - Auto Block Rule"
    metric_name = "SecurityAutomationsAutoBlockRule"
    predicates {
        data_id = "${aws_waf_ipset.WAFAutoBlockSet.id}"
        negated = false
        type = "IPMatch"
    }
}
