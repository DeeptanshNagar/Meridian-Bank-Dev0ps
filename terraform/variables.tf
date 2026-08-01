variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project/prefix used for naming resources"
  type        = string
  default     = "meridian-bank"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository for the app image"
  type        = string
  default     = "devsecops-bankapp"
}

variable "github_org" {
  description = "GitHub org or username that owns the repo (used to scope the OIDC trust policy)"
  type        = string
  default     = "DeeptanshNagar"
}

variable "github_repo" {
  description = "GitHub repository name (used to scope the OIDC trust policy)"
  type        = string
  default     = "Meridian-Bank-Dev0ps"
}

variable "app_instance_type" {
  description = "EC2 instance type for the Spring Boot app host"
  type        = string
  default     = "t3.medium"
}

variable "ollama_instance_type" {
  description = "EC2 instance type for the Ollama (TinyLlama) AI host"
  type        = string
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block permitted to SSH into instances (restrict this in production)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_password" {
  description = "Password stored in Secrets Manager for the MySQL app database"
  type        = string
  sensitive   = true
}
