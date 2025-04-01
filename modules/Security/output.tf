###############################
# Security Hub
###############################
output "securityhub_account_id" {
  description = "The ID of the Security Hub account"
  value       = aws_securityhub_account.main.id
}

output "enabled_security_standards" {
  description = "List of enabled security standards ARNs"
  value = [
    aws_securityhub_standards_subscription.cis.standards_arn,
    aws_securityhub_standards_subscription.pci_dss.standards_arn,
    aws_securityhub_standards_subscription.nist.standards_arn
  ]
}

###############################
# GuardDuty
###############################
output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector"
  value       = aws_guardduty_detector.main.id
}

###############################
# EBS Encryption
###############################
output "ebs_encryption_enabled" {
  description = "Status of default EBS encryption"
  value       = aws_ebs_encryption_by_default.main.enabled
}
