locals {
  enabled = module.this.enabled # Shorthand for quick reference

  sns_topic_policy_enabled = local.enabled && !var.add_sns_policy && var.sns_topic_arn != ""
  sns_topic_arn            = var.add_sns_policy && var.sns_topic_arn != "" ? var.sns_topic_arn : join("", aws_sns_topic.default[*].arn)
  endpoints                = distinct(compact(concat([local.sns_topic_arn], var.additional_endpoint_arns)))
}

data "aws_caller_identity" "default" {
  count = local.enabled ? 1 : 0
}

module "topic_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["efs", "threshold", "alerts"]

  context = module.this.context
}

resource "aws_sns_topic" "default" {
  count = local.enabled ? 1 : 0
  name  = module.topic_label.id
}

resource "aws_sns_topic_policy" "default" {
  count  = local.sns_topic_policy_enabled ? 1 : 0
  arn    = local.sns_topic_arn
  policy = join("", data.aws_iam_policy_document.sns_topic_policy[*].json)
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count = local.enabled ? 1 : 0

  statement {
    sid = "AllowManageSNS"

    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect    = "Allow"
    resources = aws_sns_topic.default[*].arn

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = data.aws_caller_identity.default[*].account_id
    }
  }

  statement {
    sid       = "Allow CloudwatchEvents"
    actions   = ["sns:Publish"]
    resources = aws_sns_topic.default[*].arn

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}
