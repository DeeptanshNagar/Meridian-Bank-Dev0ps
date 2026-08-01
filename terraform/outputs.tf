output "ecr_repository_url" {
  description = "Push images here from CI"
  value       = aws_ecr_repository.app.repository_url
}

output "github_actions_role_arn" {
  description = "Set this as the AWS_ROLE_ARN GitHub Actions secret"
  value       = aws_iam_role.github_actions.arn
}

output "app_instance_public_ip" {
  description = "Public IP of the Spring Boot app host"
  value       = aws_instance.app.public_ip
}

output "ollama_instance_private_ip" {
  description = "Private IP of the Ollama AI host"
  value       = aws_instance.ollama.private_ip
}

output "secrets_manager_arn" {
  description = "ARN of the runtime secrets bundle"
  value       = aws_secretsmanager_secret.app_secrets.arn
}
