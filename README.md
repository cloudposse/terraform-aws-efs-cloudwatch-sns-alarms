# terraform-aws-cloudwatch-alarms-efs

Create a set of sane EFS CloudWatch alerts for monitoring the health of an EFS resource.

| area    | metric             | comparison operator  | threshold         | rationale                                                          |
|---------|--------------------|----------------------|-------------------|--------------------------------------------------------------------|
| Storage | BurstCreditBalance | `<`                  | 192000000000      | 192 GB in Bytes (last hour where you can burst at 100 MB/sec)      |
| Storage | PercentIOLimit     | `>`                  | 95                | When the IO limit has been exceeded, the system performance drops. |

## Example

```hcl
resource "aws_efs_file_system" "default" {
  creation_token = "app"
}

module "efs_alarms" {
  source         = "../../"
  filesystem_id = "${aws_efs_file_system.default.id}"
}
```

## Variables
| Name                           | Description                                                                               | Required |
|--------------------------------|-------------------------------------------------------------------------------------------|----------|
| filesystem_id                  | The instance ID of the RDS database instance that you want to monitor.               		 | Yes 		 |
| sns_topic_arn                  | An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true` 		| No       |
| add_sns_policy                 | Attach a policy that allows the notifications through to the SNS topic endpoint           | No       |
| burst_credit_balance_threshold | The minimum number of burst credits that a file system should have.											 | No       |
| percent_io_limit_threshold     | IO Limit threshold 	                                                                     | No       |
