output "blog_client_repository_url" {
  description = "ECR URL for the React frontend"
  value       = aws_ecr_repository.blog_client.repository_url
}

output "blog_server_repository_url" {
  description = "ECR URL for the Node.js backend"
  value       = aws_ecr_repository.blog_server.repository_url
}
