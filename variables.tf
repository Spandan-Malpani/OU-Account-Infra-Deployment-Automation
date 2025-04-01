variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "gwlbe_subnet_cidrs" {
  description = "CIDR blocks for GWLBE subnets"
  type        = list(string)
}

variable "map_public_ip" {
  description = "Auto-assign public IP on launch for public subnets"
  type        = bool
  default     = true
}

variable "gwlbe_1_service_name" {
  description = "GWLB endpoint service name"
  type        = string
}

variable "gwlbe_2_service_name" {
  description = "GWLB endpoint service name"
  type        = string
}

variable "log_group_name" {
  description = "Name of CloudWatch Log Group for VPC Flow Logs"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain VPC Flow Logs"
  type        = number
}

variable "flow_log_traffic_type" {
  description = "Type of traffic to log"
  type        = string
  default     = "ALL"
}

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


variable "password_policy" {
  description = "IAM Password Policy settings"
  type = object({
    minimum_password_length        = number
    require_lowercase_characters   = bool
    require_uppercase_characters   = bool
    require_numbers                = bool
    require_symbols                = bool
    allow_users_to_change_password = bool
    password_reuse_prevention      = number
    max_password_age               = number
    hard_expiry                    = bool
  })
}

variable "log_group_class" {
  description = "Log group class of VPC Flow Logs"
  type        = string
}

variable "flowlog_format" {
  description = "Custom Flowlog Format"
  type = string
}

variable "flowlog_maximum_aggregation_interval" {
  description = "Maximum Aggregation Interval For flowlog"
  type        = number

  validation {
    condition     = contains([60, 600], var.flowlog_maximum_aggregation_interval)
    error_message = "Maximum aggregation interval must be either 60 (1 minute) or 600 (10 minutes)."
  }
}

variable "tags" {
  description = "Key-value pairs of tags to apply to all resources."
  type        = map(string)
}

variable "aws_region" {
  description = "Region for creation of resources"
  type        = string
}