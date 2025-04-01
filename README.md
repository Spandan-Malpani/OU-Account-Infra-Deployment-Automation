# OU-Account-Automation

This repository contains infrastructure as code to set up VPC and related networking resources in AWS accounts. There are two approaches to implement this automation:

## Approach 1: Deploy Before Adding to Organization
1. Deploy this infrastructure in the AWS account first
2. Once deployment is successful, add the account to the appropriate Organizational Unit (OU)

## Approach 2: Deploy After Adding to Organization
1. Add the AWS account to the appropriate Organizational Unit (OU)
2. Deploy this infrastructure in the member account

### Prerequisites
- AWS Account with appropriate permissions
- Terraform installed
- AWS CLI configured

### Resources Created
- VPC with DNS support
- Internet Gateway
- Public and Private Subnets across 2 AZs
- Gateway Load Balancer Endpoint Subnets
- Route Tables and Associations
- VPC Flow Logs

### Deployment Instructions
1. Clone this repository
2. Update the terraform.tfvars with appropriate values
3. Initialize Terraform:
   ```bash