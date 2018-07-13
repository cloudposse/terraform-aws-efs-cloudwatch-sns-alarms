
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| add_sns_policy | Attach a policy that allows the notifications through to the SNS topic endpoint | string | `false` | no |
| additional_endpoint_arns | Any alert endpoints, such as autoscaling, or app escaling endpoint arns that will respond to an alert | list | `<list>` | no |
| burst_credit_balance_threshold | The minimum number of burst credits that a file system should have. | string | `192000000000` | no |
| filesystem_id | The EFS file system ID that you want to monitor | string | - | yes |
| percent_io_limit_threshold | IO Limit threshold | string | `95` | no |
| sns_topic_arn | An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true` | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| sns_topic_arn | An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true` |

