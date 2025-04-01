resource "aws_iam_role" "flow_log_role" {
  name = var.flow_log_role_name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "vpc-flow-logs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  role   = aws_iam_role.flow_log_role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# AWS Support Access Role 
resource "aws_iam_role" "aws_support_role" {
  name = var.aws_support_role_name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.account_id}:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_support_role_policy_attachment" {
  role       = aws_iam_role.aws_support_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

resource "aws_iam_role" "get_credentials_report_role" {
  name = var.get_credentials_report_role_name

  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.audit_account_id}:role/CentralAccountLambdaRole"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "get_credential_report_policy" {
  role   = aws_iam_role.get_credentials_report_role.name
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"iam:GenerateCredentialReport",
				"iam:GetCredentialReport"
			],
			"Resource": "*"
		}
	]
}
EOF
}