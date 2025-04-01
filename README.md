# OU-Account-Automation

This repository contains infrastructure as code (IaC) to set up VPC and related networking resources in AWS accounts. It helps automate the deployment of networking resources, security configurations, and IAM roles for new accounts being added to an AWS Organization.

## Description

The **OU-Account-Infra-Deployment-Automation** is a solution that automates the deployment of essential resources required for networking, security, and access management in an AWS account. This infrastructure is modularized into three main components:

1. **VPC**: For networking resources like VPC, subnets, route tables, etc.
2. **Security**: Configurations for security services like AWS GuardDuty, Security Hub, IAM password policies, and S3 public access blocking.
3. **IAM**: Creation of necessary IAM roles for services like Lambda, support access, and logging.

This approach provides a standardized and generalized framework that can be used across any organization to deploy networking and security resources in AWS.

---

## Data Flow

*Add details of how the components interact within your infrastructure here. Include any data flow diagrams, sequence diagrams, or textual descriptions.*

---

## Project Structure

*Provide details of the project structure here once it's finalized.*

---

## Components

### 1. **VPC**

This component creates VPC resources (VPC, Subnets, Route Tables, Endpoint services, Flow Logs, etc.) with custom names and CIDR blocks as per the organization’s requirements.

Key tasks include:
- Creating a VPC with custom CIDR blocks.
- Setting up subnets (public/private).
- Configuring route tables and Internet Gateways.
- Enabling VPC flow logs for network traffic monitoring.

The routing is initially configured based on standard network architecture but can be customized according to specific organizational needs.

### 2. **Security**

This component configures AWS security-related services:
- **AWS GuardDuty**: Enables GuardDuty for threat detection.
- **AWS Security Hub**: Enables security standards and best practices monitoring.
- **S3 Public Access Block**: Blocks any S3 bucket from public access.
- **IAM Password Policies**: Enforces strong password policies for IAM users.

### 3. **IAM**

This module creates necessary IAM roles and policies:
- IAM roles for Lambda functions.
- IAM roles for account support and access management.
- IAM roles to allow services to interact with other AWS services.

---

## Usage Instructions

### Approach 1: Deploy Before Adding to Organization

1. Deploy this infrastructure in the AWS account first.
2. Once deployment is successful, add the account to the appropriate Organizational Unit (OU) in AWS Organizations.

### Approach 2: Deploy After Adding to Organization (Preferred)

1. Add the AWS account to the appropriate Organizational Unit (OU).
2. Deploy this infrastructure in the member account.

---

## Prerequisites

Before you begin, ensure the following prerequisites are met:

- **AWS Account**: You must have an active AWS account. If you don’t have one, you can sign up at [AWS Sign-Up](https://aws.amazon.com/).
- **AWS CLI**: AWS Command Line Interface (CLI) should be installed and configured. (Steps given below)
- **Terraform**: Terraform should be installed on your system. (Steps given below)

---

## Step 1: Install AWS CLI

### 1.1. Install AWS CLI on Windows/Linux/MacOs

1. Follow the AWS official Documentation - [AWS CLI INSTALLER GUIDE](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
2. Once installed, verify the installation by running:

 ```bash
 aws --version
 ```
This should output the version of AWS CLI, confirming it’s successfully installed.

## Step 2: Set Up IAM User and Access Keys

To interact with AWS services through the CLI, you need AWS credentials (access key ID and secret access key). These credentials should be associated with an IAM user.

### 2.1. Create an IAM User

1. Sign in to the AWS Management Console.
2. Navigate to IAM (Identity and Access Management) from the AWS console.
3. In the left-hand sidebar, click Users and then click the Add user button.
4. Provide a User name (e.g., Terraform-user).
5. On the Set permissions page, choose Attach policies directly.
6. Choose a policy, such as AdministratorAccess (or a more restrictive policy based on your use case).
7. Click Next: Tags (you can skip tagging, but it’s good practice for organizational purposes).
8. Review the configuration and click Create user.
9. Now, In the IAM dashboard, on the left-hand side, click on Users under the Access management section.
10. Click on the User you just created to generate the access keys.
11. In the user details page, click on the Security credentials tab.
12. Click the Create access key button. This will generate a new Access Key ID and Secret Access Key.
13. After the keys are generated, make sure to download the .csv file or copy the keys and store them securely.
    
Example:   
The file will contain :
- Access Key ID: `AKIAEXAMPLEKEY123`
- Secret Access Key: `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` 

> [!NOTE]
> Ensure to save the Access key ID and Secret access key that are generated. You won’t be able to retrieve them again.

## Step 3: Configure AWS CLI

Once you have your IAM user’s credentials, you can configure the AWS CLI.

### 3.1. Run AWS CLI Configuration Command

Open a terminal in VS Code or Command Prompt on Windows and run the following command:

```bash
aws configure
```
This will prompt you to enter the following:

- AWS Access Key ID: Enter the access key ID obtained in Step 2.
- AWS Secret Access Key: Enter the secret access key obtained in Step 2.
- Default region name: Enter the AWS region you want to interact with (e.g., us-west-2, us-east-1). You can always change it later.
- Default output format: Choose your preferred output format. You can choose from:
  - json (default)
  - text
  - table
  - (Keep it Empty if not required)

Example:

```bash
AWS Access Key ID [None]: <your-access-key-id>
AWS Secret Access Key [None]: <your-secret-access-key>
Default region name [None]: us-west-2
Default output format [None]:
```

## Step 4: Install & Setup Terraform 

### 4.1. Install Terraform on Windows/Linux/MacOS

Download Terraform:
Go to the [Terraform Downloads](https://developer.hashicorp.com/terraform/install) page and download the appropriate version for your OS.

**For Windows**
1. After downloading, extract the ZIP file to a directory of your choice. For example, you can extract it to C:\Terraform.
2. Right-click on 'This PC' (or 'Computer') and select Properties.
3. Click on Advanced system settings on the left.
4. In the System Properties window, click the Environment Variables button.
5. Under System variables, scroll down to select the Path variable and click Edit.
6. In the Edit Environment Variable dialog, click New and then add the path to the directory where you extracted Terraform (e.g., 
   C:\Terraform). For example, if you extracted Terraform to C:\Terraform, add C:\Terraform to your PATH.
7. Click OK to save and close all the dialogs.
8. Verify Installation: Open Command Prompt and run the following command:

```bash
terraform --version
```
If installed correctly, you should see the version of Terraform installed.

## Step 5: Configuring Backend

### 5.1. Creating Backend S3 Bucket to store Terraform state file
 
 1. Navigate to S3 Console
 2. Click on the "Create bucket" Button
 3. Enter Bucket Name, choose a globally unique name for your S3 bucket. Example: my-terraform-bucket-123
 4. Select a Region, choose an AWS region where your bucket will reside.
 5. Set Bucket Configuration Options (Optional)
      - Versioning: You can enable versioning if you want to keep multiple versions of the same object in your bucket.
      - Tags: You can add metadata to the bucket by adding tags (key-value pairs).
      - Object Lock: If you need to enforce write once, read many (WORM) protection for the objects in the bucket, enable Object Lock.
      - Encryption: Enable encryption to automatically encrypt objects when they are uploaded to the bucket.
      - Advanced settings: Additional settings such as logging, website hosting, and replication.
 6. Review and Create.

## Provisioning

### 1. Clone the repository on your local machine

```bash
git clone <repository-url>
cd OU-Account-Infra-Deployment-Automation/
```
### 2. Adding backend configuration

 - In command prompt open the file `backend.tf` inside the project directory OR Open the project in VS Code (Or any other code editor) 
   and open the file `backend.tf` .
 - In the `backend.tf` whick looks like this:

```hcl
terraform {
  backend "s3" {
    bucket         = "<your-backend-s3-bucket-name>" # Enter the name of the S3 bucket you created
    key            = "terraform.tfstate"
    region         = "<aws-region>" # Region of Backend S3 Bucket you created
    encrypt        = true
  }
}
```
- After making the necessary changes make sure to save the file.

> [!NOTE] 
> Before moving to the next steps make sure that terraform version and aws credentials are configured for created user in the present 
> working directory by running the commands mentioned above for the same once again.

### 3. Deploying the Infrastructure

terraform init
terraform validate
terraform plan
terraform apply

check resources

terraform destroy 

add a note saying:
as this is not a dynamic project and resources once provisioned need not be changed, monitor the resources and configurations for 1-2 weeks and if everything is as per requiremnet and successful you go ahead and delete the user and the backend s3 bucket to prevent from destruction of resources.
