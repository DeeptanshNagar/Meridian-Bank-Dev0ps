# Meridian Bank — Infrastructure as Code (Terraform)

This module codifies the AWS setup that the main README currently walks through
manually: ECR repo, IAM OIDC provider + GitHub Actions role, Secrets Manager
secret, security groups, and the two EC2 hosts (app server + Ollama AI host).

## What this replaces (manual steps → Terraform resources)

| Manual step in original README | Terraform resource |
|---|---|
| Create private ECR repo `devsecops-bankapp` | `aws_ecr_repository.app` |
| Launch Ubuntu 22.04 EC2 app host + user-data script | `aws_instance.app` |
| Launch Ollama EC2 host | `aws_instance.ollama` |
| Security groups (22, 8080, 11434) | `aws_security_group.app`, `aws_security_group.ollama` |
| OIDC identity provider for GitHub Actions | `aws_iam_openid_connect_provider.github` |
| `GitHubActionsRole` + policy attachments | `aws_iam_role.github_actions` + attachments |
| `bankapp/prod-secrets` in Secrets Manager | `aws_secretsmanager_secret.app_secrets` |

## Usage

```bash
terraform init
terraform plan  -var="key_pair_name=your-keypair" -var="db_password=your-password"
terraform apply -var="key_pair_name=your-keypair" -var="db_password=your-password"
```

Or create a `terraform.tfvars` file instead of passing `-var` flags:

```hcl
key_pair_name = "your-keypair"
db_password   = "your-password"
```

After `apply`, take the printed outputs and set them as GitHub Actions secrets:
- `AWS_ROLE_ARN` ← `github_actions_role_arn` output
- `ECR_REPOSITORY` ← already known (`devsecops-bankapp`)
- `EC2_HOST` ← `app_instance_public_ip` output

## Notes / things to harden before calling this "production"

- `allowed_ssh_cidr` defaults to `0.0.0.0/0` — restrict it to your IP or a
  bastion in a real deployment.
- This uses the account's **default VPC** for simplicity. A real production
  setup should use a dedicated VPC with public/private subnet separation
  (app in public subnet, Ollama + DB in private subnet).
- State is local by default — for team use, configure an S3 + DynamoDB
  backend for remote state and locking.
- No `terraform validate` was run against live AWS here (this sandbox has no
  network path to `releases.hashicorp.com` to install the CLI) — the HCL was
  hand-reviewed and brace/paren-checked, but run `terraform validate` and
  `terraform plan` yourself before applying.
