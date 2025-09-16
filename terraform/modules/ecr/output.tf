output "repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "ECR repository ARN"
  value       = aws_ecr_repository.private_ecr.arn
}

output "repository_name" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.this.name
}