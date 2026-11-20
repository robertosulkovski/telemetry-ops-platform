
# Apache StreamPipes — Technical Architecture

## 1. Project Overview

Apache StreamPipes is the application selected for the TelemetryOps infrastructure laboratory.

The project focuses on infrastructure provisioning, deployment, security, automation and monitoring using AWS, Terraform, Linux and Docker.

Application development is outside the scope of this project.

## 2. Application

- Application: Apache StreamPipes
- Version selected for analysis: 0.98.0
- Deployment approach: Docker Compose
- Hosting environment: AWS EC2
- Operating system: Ubuntu Server 24.04 LTS

## 3. Infrastructure Architecture

### AWS Resources

| Component | Configuration |
|---|---|
| Region | us-east-1 |
| VPC | 10.0.0.0/16 |
| Public subnet | 10.0.1.0/24 |
| Internet Gateway | Configured |
| Route Table | Public route |
| Security Group | TelemetryOps |
| EC2 | m7i-flex.large |
| Operating System | Ubuntu Server 24.04 LTS |
| Root volume | 30 GB gp3 |

Infrastructure is provisioned using Terraform.

### Server Environment

The EC2 instance has:

- Docker Engine installed
- Docker Compose installed
- SSH access configured using an ED25519 key pair

Docker installation was validated using the hello-world container.

## 4. Application Deployment Architecture

The planned application deployment uses Docker Compose.

The StreamPipes services will communicate through an internal Docker network.

Application containers, persistent volumes and exposed ports will be reviewed before deployment.

The official StreamPipes Compose configuration must be inspected and validated before execution.

## 5. Security Architecture

Current controls:

- SSH restricted to the configured administrative IP.
- AWS Security Groups controlling inbound traffic.
- SSH authentication using a public/private key pair.
- Sensitive Terraform files excluded from Git.

Planned improvements:

- Evaluate WireGuard VPN for administrative and application access.
- Keep internal application services inaccessible directly from the internet.
- Review container images, versions, ports and persistent volumes.
- Evaluate EBS encryption.
- Improve monitoring and security logging.

## 6. CI/CD

GitHub Actions currently performs Terraform validation on Pull Requests targeting master.

The workflow includes:

- Terraform Format
- Terraform Init
- Terraform Validate

Infrastructure deployment through automated Terraform Apply is not currently configured.

## 7. Current Implementation Status

Implemented:

- AWS VPC and networking resources.
- Security Group.
- EC2 instance.
- SSH access.
- Docker Engine and Docker Compose installation.
- Terraform validation through GitHub Actions.
- GitHub branch protection and Pull Request workflow.

Pending:

- StreamPipes deployment.
- VPN configuration.
- Application access security.
- Monitoring and troubleshooting.
- Automated deployment pipeline.

## 8. Scope

The TelemetryOps laboratory focuses on:

- AWS infrastructure.
- Infrastructure as Code.
- Linux administration.
- Docker and Docker Compose.
- Networking and VPN.
- CI/CD automation.
- Security and monitoring.
