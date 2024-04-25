provider "aws" {
  region = var.region

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

resource "aws_efs_file_system" "default" {
  creation_token = "app"
}

module "efs_alarms" {
  source        = "../../"
  filesystem_id = aws_efs_file_system.default.id

  context = module.this.context
}
