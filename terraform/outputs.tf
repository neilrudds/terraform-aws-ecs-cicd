output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_alb.alb.dns_name
}

output "ecr_repo_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.ecr-repo.repository_url
}