#Cloudwatch log group for VPC flowlogs
resource "aws_cloudwatch_log_group" "vpc_flow_logs_group" {
  name              = var.log_group_name
  retention_in_days = 0  # Never expire
  log_group_class   = var.log_group_class

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-flow-logs"
  })
}

resource "aws_vpc" "custom" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.tags,{
    Name = var.vpc_name
  })
}

resource "aws_internet_gateway" "main" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-igw"
  })
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  depends_on = [aws_vpc.custom]
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = var.map_public_ip

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-public-subnet-1"
  })
}

resource "aws_subnet" "public_subnet_2" {
  depends_on = [aws_vpc.custom]
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = var.map_public_ip

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-public-subnet-2"
  })
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  depends_on = [aws_vpc.custom]
  vpc_id            = aws_vpc.custom.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-private-subnet-1"
  })
}

resource "aws_subnet" "private_subnet_2" {
  depends_on = [aws_vpc.custom]
  vpc_id            = aws_vpc.custom.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-private-subnet-2"
  })
}

# GWLBE Subnets
resource "aws_subnet" "gwlbe_subnet_1" {
  depends_on = [aws_vpc.custom]
  vpc_id            = aws_vpc.custom.id
  cidr_block        = var.gwlbe_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlbe-subnet-1"
  })
}

resource "aws_subnet" "gwlbe_subnet_2" {
  depends_on = [aws_vpc.custom]
  vpc_id            = aws_vpc.custom.id
  cidr_block        = var.gwlbe_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlbe-subnet-2"
  })
}

# Route Tables
resource "aws_route_table" "public_rt_1" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-public-rt-1"
  })
}

resource "aws_route_table" "public_rt_2" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-public-rt-2"
  })
}

resource "aws_route_table" "private_rt_1" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-private-rt-1"
  })
}

resource "aws_route_table" "private_rt_2" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-private-rt-2"
  })
}

resource "aws_route_table" "gwlb_ingress" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlb-ingress"
  })
}

resource "aws_route_table" "gwlbe" {
  depends_on = [aws_vpc.custom]
  vpc_id = aws_vpc.custom.id

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlbe"
  })
}

# VPC Endpoints
resource "aws_vpc_endpoint" "gwlbe_1" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.gwlbe_subnet_1
  ]
  vpc_id            = aws_vpc.custom.id
  service_name      = var.gwlbe_1_service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.gwlbe_subnet_1.id]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlbe-1"
  })
}

resource "aws_vpc_endpoint" "gwlbe_2" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.gwlbe_subnet_2
  ]
  vpc_id            = aws_vpc.custom.id
  service_name      = var.gwlbe_2_service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.gwlbe_subnet_2.id]

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-gwlbe-2"
  })
}

# Route Table Associations
resource "aws_route_table_association" "public_1" {
  depends_on = [
    aws_subnet.public_subnet_1,
    aws_route_table.public_rt_1
  ]
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt_1.id
}

resource "aws_route_table_association" "public_2" {
  depends_on = [
    aws_subnet.public_subnet_2,
    aws_route_table.public_rt_2
  ]
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt_2.id
}

resource "aws_route_table_association" "private_1" {
  depends_on = [
    aws_subnet.private_subnet_1,
    aws_route_table.private_rt_1
  ]
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_2" {
  depends_on = [
    aws_subnet.private_subnet_2,
    aws_route_table.private_rt_2
  ]
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt_2.id
}

resource "aws_route_table_association" "gwlbe_1" {
  depends_on = [
    aws_subnet.gwlbe_subnet_1,
    aws_route_table.gwlbe
  ]
  subnet_id      = aws_subnet.gwlbe_subnet_1.id
  route_table_id = aws_route_table.gwlbe.id
}

resource "aws_route_table_association" "gwlbe_2" {
  depends_on = [
    aws_subnet.gwlbe_subnet_2,
    aws_route_table.gwlbe
  ]
  subnet_id      = aws_subnet.gwlbe_subnet_2.id
  route_table_id = aws_route_table.gwlbe.id
}

# Routes
resource "aws_route" "public_to_endpoint_az1" {
  depends_on = [
    aws_route_table.public_rt_1,
    aws_vpc_endpoint.gwlbe_1
  ]
  route_table_id         = aws_route_table.public_rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlbe_1.id
}

resource "aws_route" "public_to_endpoint_az2" {
  depends_on = [
    aws_route_table.public_rt_2,
    aws_vpc_endpoint.gwlbe_2
  ]
  route_table_id         = aws_route_table.public_rt_2.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlbe_2.id
}

resource "aws_route" "to_igw" {
  depends_on = [
    aws_route_table.gwlbe,
    aws_internet_gateway.main
  ]
  route_table_id         = aws_route_table.gwlbe.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# VPC Flow Logs
resource "aws_flow_log" "vpc_flow_log" {
  depends_on = [
    aws_vpc.custom,
    aws_cloudwatch_log_group.vpc_flow_logs_group
  ]

  iam_role_arn    = var.flow_log_role_arn
  vpc_id          = aws_vpc.custom.id
  traffic_type    = var.flow_log_traffic_type
  max_aggregation_interval = var.flowlog_maximum_aggregation_interval
  log_format      = var.flowlog_format
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs_group.arn

  tags = merge(var.tags,{
    Name = "${var.vpc_name}-flow-logs"
  })
}
