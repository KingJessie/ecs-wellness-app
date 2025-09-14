output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.mainvpc.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = [aws_subnet.az1.id, aws_subnet.az2.id]
}