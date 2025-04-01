#Security
password_policy = {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24
  max_password_age               = 90
  hard_expiry                    = false
  aws_region                     = "us-east-1"
}


#VPC
aws_region                           = "us-east-1"
vpc_name                             = "Custom-VPC"
vpc_cidr_block                       = "10.0.0.0/16"
igw_name                             = "custom-igw"
availability_zones                   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs                  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs                 = ["10.0.3.0/24", "10.0.4.0/24"]
gwlbe_subnet_cidrs                   = ["10.0.5.0/24", "10.0.6.0/24"]
gwlbe_1_service_name                 = "gwlbe-1"
gwlbe_2_service_name                 = "gwlbe-2"
log_group_name                       = "VPC-Flowlog-Group"
log_group_class                      = "STANDARD" # Make Sure it's in upper case, [STANDARD or INFREQUENT_ACCESS]
log_retention_days                   = 0          # 0 means never expire
flowlog_format                       = "$${version} $${account-id} $${interface-id} $${pkt-srcaddr} $${srcaddr} $${dstaddr} $${pkt-dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${log-status} $${flow-direction} $${tcp-flags} $${action}"
flowlog_maximum_aggregation_interval = 60
tags = {
  Environment = "Test"
}

#IAM
flow_log_role_name               = "vpc_flowlog_role"
aws_support_role_name            = "aws_support_role"
account_id                       = "467350265809" # ID of the Account in which the resources are being deployed
get_credentials_report_role_name = "Get-Credentials-ReportRole"
audit_account_id                 = "539927596611" #ID of audit Account
