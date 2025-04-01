# IAM module should be first as other modules might depend on IAM roles
module "iam" {
  source = "./modules/IAM"

  flow_log_role_name               = var.flow_log_role_name
  aws_support_role_name            = var.aws_support_role_name
  account_id                       = var.account_id
  get_credentials_report_role_name = var.get_credentials_report_role_name
  audit_account_id                 = var.audit_account_id
}

# VPC module with dependency on IAM for flow logs
module "vpc" {
  source = "./modules/vpc"

  depends_on = [module.iam]

  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  igw_name             = var.igw_name
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  gwlbe_subnet_cidrs   = var.gwlbe_subnet_cidrs
  map_public_ip        = var.map_public_ip
  gwlbe_1_service_name = var.gwlbe_1_service_name
  gwlbe_2_service_name = var.gwlbe_2_service_name
  tags                 = var.tags
  # Flow log configuration
  log_group_name                       = var.log_group_name
  log_retention_days                   = var.log_retention_days
  log_group_class                      = var.log_group_class
  flow_log_role_arn                    = module.iam.flow_log_role_arn
  flow_log_role_name                   = var.flow_log_role_name
  flow_log_traffic_type                = var.flow_log_traffic_type
  flowlog_format = var.flowlog_format
  flowlog_maximum_aggregation_interval = var.flowlog_maximum_aggregation_interval

  # DNS settings
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  #IAM 
  aws_support_role_name            = var.aws_support_role_name
  account_id                       = var.account_id
  get_credentials_report_role_name = var.get_credentials_report_role_name
  audit_account_id                 = var.audit_account_id
}

# Security module after IAM is set up
module "security" {
  source = "./modules/Security"

  depends_on = [module.iam]

  password_policy = {
    minimum_password_length        = var.password_policy.minimum_password_length
    require_lowercase_characters   = var.password_policy.require_lowercase_characters
    require_uppercase_characters   = var.password_policy.require_uppercase_characters
    require_numbers                = var.password_policy.require_numbers
    require_symbols                = var.password_policy.require_symbols
    allow_users_to_change_password = var.password_policy.allow_users_to_change_password
    password_reuse_prevention      = var.password_policy.password_reuse_prevention
    max_password_age               = var.password_policy.max_password_age
    hard_expiry                    = var.password_policy.hard_expiry
  }

  aws_region = var.aws_region
}
