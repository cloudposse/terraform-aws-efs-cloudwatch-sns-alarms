<!-- markdownlint-disable -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.burst_credit_balance_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.percent_io_limit_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_sns_policy"></a> [add\_sns\_policy](#input\_add\_sns\_policy) | Attach a policy that allows the notifications through to the SNS topic endpoint | `string` | `"false"` | no |
| <a name="input_additional_endpoint_arns"></a> [additional\_endpoint\_arns](#input\_additional\_endpoint\_arns) | Any alert endpoints, such as autoscaling, or app escaling endpoint arns that will respond to an alert | `list(string)` | `[]` | no |
| <a name="input_burst_credit_balance_threshold"></a> [burst\_credit\_balance\_threshold](#input\_burst\_credit\_balance\_threshold) | The minimum number of burst credits that a file system should have. | `string` | `"192000000000"` | no |
| <a name="input_filesystem_id"></a> [filesystem\_id](#input\_filesystem\_id) | The EFS file system ID that you want to monitor | `string` | n/a | yes |
| <a name="input_percent_io_limit_threshold"></a> [percent\_io\_limit\_threshold](#input\_percent\_io\_limit\_threshold) | IO Limit threshold | `string` | `"95"` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true` |
<!-- markdownlint-restore -->
