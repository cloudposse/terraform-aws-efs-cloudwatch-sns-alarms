locals {
  thresholds = {
    BurstCreditBalanceThreshold = "${max(var.burst_credit_balance_threshold, 0)}"
    PercentIOLimitThreshold     = "${min(max(var.percent_io_limit_threshold, 0), 100)}"
  }

  alert_for     = "efs"
  sns_topic_arn = "${var.sns_topic_arn == "" ? aws_sns_topic.default.arn : var.sns_topic_arn }"
}

resource "aws_cloudwatch_metric_alarm" "burst_credit_balance_too_low" {
  alarm_name          = "burst_credit_balance_too_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BurstCreditBalance"
  namespace           = "AWS/EFS"
  period              = "600"
  statistic           = "Average"
  threshold           = "${local.thresholds["BurstCreditBalanceThreshold"]}"
  alarm_description   = "Average burst credit balance over last 10 minutes too low, expect a significant performance drop soon"
  alarm_actions       = ["${local.sns_topic_arn}"]
  ok_actions          = ["${local.sns_topic_arn}"]

  dimensions {
    FileSystemId = "${var.filesystem_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "percent_io_limit_too_high" {
  alarm_name          = "percent_io_limit_too_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "PercentIOLimit"
  namespace           = "AWS/EFS"
  period              = "600"
  statistic           = "Maximum"
  threshold           = "${local.thresholds["PercentIOLimitThreshold"]}"
  alarm_description   = "I/O limit has been reached, consider using Max I/O performance mode"
  alarm_actions       = ["${local.sns_topic_arn}"]
  ok_actions          = ["${local.sns_topic_arn}"]

  dimensions {
    FileSystemId = "${var.filesystem_id}"
  }
}
