# Configura o provider AWS para o projeto TelemetryOps
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


# Define a região AWS utilizada pelo projeto
provider "aws" {
  region = var.aws_region
}

# Consulta as zonas de disponibilidade disponíveis na região AWS
data "aws_availability_zones" "available" {
  state = "available"
}
