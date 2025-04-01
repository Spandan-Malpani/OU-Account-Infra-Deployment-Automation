output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.custom.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.custom.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "gwlbe_subnet_ids" {
  description = "List of IDs of GWLBE subnets"
  value       = [aws_subnet.gwlbe_subnet_1.id, aws_subnet.gwlbe_subnet_2.id]
}

output "vpc_endpoint_ids" {
  description = "List of VPC Endpoint IDs"
  value       = [aws_vpc_endpoint.gwlbe_1.id, aws_vpc_endpoint.gwlbe_2.id]
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = [aws_route_table.public_rt_1.id, aws_route_table.public_rt_2.id]
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = [aws_route_table.private_rt_1.id, aws_route_table.private_rt_2.id]
}

output "gwlbe_route_table_id" {
  description = "ID of the GWLBE route table"
  value       = aws_route_table.gwlbe.id
}

output "gwlb_ingress_route_table_id" {
  description = "ID of the GWLB ingress route table"
  value       = aws_route_table.gwlb_ingress.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "vpc_flow_log_group_arn" {
  description = "ARN of the VPC Flow Logs CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.vpc_flow_logs_group.arn
}

output "vpc_flow_log_id" {
  description = "ID of the VPC Flow Log"
  value       = aws_flow_log.vpc_flow_log.id
}

output "availability_zones" {
  description = "List of availability zones used in the VPC"
  value       = var.availability_zones
}
