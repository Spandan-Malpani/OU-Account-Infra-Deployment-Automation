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
    
The file will contain:
Access Key ID: `AKIAEXAMPLEKEY123`
Secret Access Key: `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` 

> [!NOTE]: Ensure to save the Access key ID and Secret access key that are generated. You won’t be able to retrieve them again.

Step 3: Configure AWS CLI
Once you have your IAM user’s credentials, you can configure the AWS CLI.

3.1. Run AWS CLI Configuration Command
Open a terminal in VS Code or Command Prompt on Windows and run the following command:

bash
aws configure
This will prompt you to enter the following:

AWS Access Key ID: Enter the access key ID obtained in Step 2.

AWS Secret Access Key: Enter the secret access key obtained in Step 2.

Default region name: Enter the AWS region you want to interact with (e.g., us-west-2, us-east-1). You can always change it later.

Default output format: Choose your preferred output format. You can choose from:

json (default)

text

table
(Keep it Empty if not required)

Example:

bash
Copy
AWS Access Key ID [None]: <your-access-key-id>
AWS Secret Access Key [None]: <your-secret-access-key>
Default region name [None]: us-west-2
Default output format [None]:

- Terraform setup
  
Step 1: Install Terraform
1.1. Install Terraform on Windows
Download Terraform:

Go to the Terraform Downloads page and download the appropriate version for Windows (usually a .zip file).

Extract the ZIP File:

After downloading, extract the ZIP file to a directory of your choice. For example, you can extract it to C:\Terraform.

Add Terraform to System's PATH:

Right-click on 'This PC' (or 'Computer') and select Properties.

Click on Advanced system settings on the left.

In the System Properties window, click the Environment Variables button.

Under System variables, scroll down to select the Path variable and click Edit.

In the Edit Environment Variable dialog, click New and then add the path to the directory where you extracted Terraform (e.g., C:\Terraform).

For example, if you extracted Terraform to C:\Terraform, add C:\Terraform to your PATH.

Click OK to save and close all the dialogs.

Verify Installation:

Open Command Prompt and run the following command:

bash
Copy
terraform -v
If installed correctly, you should see the version of Terraform installed.

1.2. Install Terraform on macOS
Install via Homebrew:

If you don’t have Homebrew, install it using:

bash
Copy
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
Install Terraform using Homebrew:

bash
Copy
brew install terraform
Verify Installation:

In the terminal, check the version of Terraform:

bash
Copy
terraform -v
1.3. Install Terraform on Linux
Download the Terraform ZIP File:

bash
Copy
wget https://releases.hashicorp.com/terraform/<version>/terraform_<version>_linux_amd64.zip
Replace <version> with the desired version (e.g., 1.4.0).

Extract the ZIP File:

bash
Copy
unzip terraform_<version>_linux_amd64.zip
Move Terraform to a Directory in Your PATH:

bash
Copy
sudo mv terraform /usr/local/bin/
Verify Installation:

Run the following command to check if Terraform was installed successfully:

bash
Copy
terraform -v
Step 2: Set Up Terraform in Environment Variables
2.1. Setting Environment Variables on Windows
To ensure that you can run Terraform from any Command Prompt, you need to configure its path in the system’s environment variables.

Open Environment Variables:

Right-click on This PC or Computer, then select Properties.

Click Advanced system settings on the left, then Environment Variables at the bottom.

Add Terraform Path to System PATH:

Under System variables, find and select Path, then click Edit.

In the Edit Environment Variable dialog, click New.

Add the full path to the directory where terraform.exe was extracted. For example:

If you extracted Terraform to C:\Terraform, add C:\Terraform to your Path variable.

Click OK to save and close all the windows.

Verify Configuration:

Open a Command Prompt window and run:

bash
Copy
terraform -v
If correctly configured, this will display the version of Terraform installed.

2.2. Setting Environment Variables on macOS/Linux
To ensure Terraform is accessible globally, you need to configure the path in your shell profile.

Open your shell profile file in a text editor:

bash
Copy
nano ~/.bash_profile     # For bash on macOS
nano ~/.bashrc           # For bash on Linux
nano ~/.zshrc            # For Zsh on macOS
Add the Terraform directory to the PATH:

For example, if you installed Terraform in /usr/local/bin/ (common for macOS/Linux), add the following line to the file:

bash
Copy
export PATH=$PATH:/usr/local/bin
If you manually extracted Terraform to a specific directory (e.g., /home/username/terraform), add that path:

bash
Copy
export PATH=$PATH:/home/username/terraform
Apply the changes:

For bash on macOS/Linux:

bash
Copy
source ~/.bash_profile  # For macOS or bash users
source ~/.bashrc        # For Linux bash users
For zsh:

bash
Copy
source ~/.zshrc
Verify Installation:

Open a new terminal and run:

bash
Copy
terraform -v
You should see the version of Terraform installed, indicating the system is properly configured.

### Provisioning

Clone the repository
'add steps to clone a repository over here -chatgpt'

- Creating Backend S3 Bucket to store Terraform state file
- 
  Create an S3 bucket
   
  in the backend.tf file

  terraform {
  backend "s3" {
    bucket         = "<your-backend-s3-bucket-name>" 
    key            = "terraform.tfstate"
    region         = "<aws-region>" # Region of Backend S3 Bucket
    encrypt        = true
  }
}
make changes to the name and region

make sure terraform version is visible in pwd, aws credentials are configured for created user
now add steps and also xplain what each command does
terraform init
terraform validate
terraform plan
terraform apply

check resources

terraform destroy 

add a note saying:
as this is not a dynamic project and resources once provisioned need not be changed, monitor the resources and configurations for 1-2 weeks and if everything is as per requiremnet and successful you go ahead and delete the user and the backend s3 bucket to prevent from destruction of resources.
