## AWS WAF Security Automation - modular with Terraform

For more info/help, contact us: support@cerbo.io (http://cerbo.io)

This provides a modular way to deploy the WAF Reference Architecture (see bellow for image)
The key things about this (and comparison with the official Amazon
Cloud Formation) are:
* It is ridiculously fast - 6-8x faster than Amazon's Cloud Formation method
* It provides roll-back, undo, recovery, and clean delete abilities - all automatically
* It is modular (with Terraform)! This is extremely important. Any component can be replaced, extended, or integrated with something else. You can very easily re-purpose all of this (or any part) for a different AWS Automation project/purpose.

### Getting Started is very simple

First: Edit "amazon-cred-file.tf", and point to your AWS cred file.

Then, for each project/customer's CDN S3 bucket, run:

```


% ./waf --help
Usage: ./waf <customer> <s3-logs-bucket> <command>

<command> Options:
    create = create a new WAF setup for <customer>
    delete = delete a given <customer> WAF setup

Example: ./waf cerbo s3-bucket-name create
Example: ./waf customer01 s3-bucket-name delete
```


#### WAF Reference Architecture:
https://d0.awsstatic.com/aws-answers/answers-images/waf-solution-architecture.png

#### Documentation on WAF Security Automation:
http://docs.aws.amazon.com/solutions/latest/aws-waf-security-automations/architecture.html

#### Amazon WAF 4 Steps to customization:
http://docs.aws.amazon.com/solutions/latest/aws-waf-security-automations/deployment.html

#### Amazon's WAF Security Lambdas (latest via GitHub):
https://github.com/awslabs/aws-waf-security-automations

#### Cloud Formation for WAF Reference Architecture:
* The Cloud Formation "way" has many problems, one of which is that it's a single shot "all or nothing" approach.
* It is ridiculously slow. 
* This is mostly to compare to our automated deployment, and make sure everything is the same
https://console.aws.amazon.com/cloudformation/designer/home?region=us-east-1&templateUrl=https://s3.amazonaws.com/solutions-reference/aws-waf-security-automations/latest/aws-waf-security-automations.template

#### LICENSE
```
Copyright 2016 Cerbo.IO, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
