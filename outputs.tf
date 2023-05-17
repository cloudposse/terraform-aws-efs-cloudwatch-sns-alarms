output "sns_topic_arn" {
  value       = local.sns_topic_arn
  description = "An SNS topic ARN that has already been created. Its policy must already allow access from CloudWatch Alarms, or set `add_sns_policy` to `true`"
}
