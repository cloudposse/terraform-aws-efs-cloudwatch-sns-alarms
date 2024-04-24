locals {
  thresholds = {
    BurstCreditBalanceThreshold = max(var.burst_credit_balance_threshold, 0)
    PercentIOLimitThreshold     = min(max(var.percent_io_limit_threshold, 0), 100)
  }

  alarm_names = toset([
    "burst_credit_balance_too_low",
    "percent_io_limit_too_high",
  ])
}

module "label" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  for_each = local.alarm_names

  attributes = [each.key]

  context = module.this.context
}

resource "aws_cloudwatch_metric_alarm" "burst_credit_balance_too_low" {
  count = local.enabled ? 1 : 0

  alarm_name          = module.label["burst_credit_balance_too_low"].id
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BurstCreditBalance"
  namespace           = "AWS/EFS"
  period              = "600"
  statistic           = "Average"
  threshold           = local.thresholds["BurstCreditBalanceThreshold"]
  alarm_description   = "Average burst credit balance over last 10 minutes too low, expect a significant performance drop soon"
  alarm_actions       = local.endpoints
  ok_actions          = local.endpoints

  dimensions = {
    FileSystemId = var.filesystem_id
  }
}

resource "aws_cloudwatch_metric_alarm" "percent_io_limit_too_high" {
  count = local.enabled ? 1 : 0

  alarm_name          = module.label["percent_io_limit_too_high"].id
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "PercentIOLimit"
  namespace           = "AWS/EFS"
  period              = "600"
  statistic           = "Maximum"
  threshold           = local.thresholds["PercentIOLimitThreshold"]
  alarm_description   = "I/O limit has been reached, consider using Max I/O performance mode"
  alarm_actions       = local.endpoints
  ok_actions          = local.endpoints

  dimensions = {
    FileSystemId = var.filesystem_id
  }
}
