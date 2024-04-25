
output "efs_alarms_sns_topic_arn" {
  value = module.efs_alarms.sns_topic_arn
}

output "efs_id" {
  value = aws_efs_file_system.default.id
}
