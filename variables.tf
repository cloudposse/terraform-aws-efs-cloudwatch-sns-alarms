variable "filesystem_id" {
  description = "The EFS file system ID that you want to monitor"
  type        = "string"
}

variable "sns_topic_arn" {
  description = "An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true`"
  default     = ""
  type        = "string"
}

variable "add_sns_policy" {
  description = "Attach a policy that allows the notifications through to the SNS topic endpoint"
  default     = "false"
  type        = "string"
}

variable "burst_credit_balance_threshold" {
  description = "The minimum number of burst credits that a file system should have."
  type        = "string"
  default     = "192000000000"

  # 192 GB in Bytes (last hour where you can burst at 100 MB/sec)
}

variable "percent_io_limit_threshold" {
  description = "IO Limit threshold"
  type        = "string"
  default     = "95"
}
