# Flow Log Role Variables
variable "flow_log_role_name" {
  description = "Name of the IAM role for VPC flow logs"
  type        = string
}

# AWS Support Role Variables
variable "aws_support_role_name" {
  description = "Name of the AWS Support access role"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID where the role will be created"
  type        = string
}

# Get Credentials Report Role Variables
variable "get_credentials_report_role_name" {
  description = "Name of the role for getting credentials report"
  type        = string
}

variable "audit_account_id" {
  description = "AWS Account ID of the audit account"
  type        = string
}
