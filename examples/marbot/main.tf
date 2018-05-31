variable "marbot_endpoint_id" {
  default = ""
}

variable "region" {
  default = "eu-west-2"
}

resource "aws_sns_topic_subscription" "subscribe_marbot" {
  count     = "${var.marbot_endpoint_id != "" ? 1 : 0}"
  topic_arn = "${module.alarms.sns_topic_arn}"
  protocol  = "https"
  endpoint  = "https://api.marbot.io/v1/endpoint/${var.marbot_endpoint_id}"
}

resource "aws_efs_file_system" "default" {
  creation_token = "app"
}

module "alarms" {
  source         = "github::https://github.com/bitflight-public/terraform-aws-rds-alerts.git?ref=master"
  db_instance_id = "${aws_efs_file_system.default.id}"
}

provider "aws" {
  region = "${var.region}"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}