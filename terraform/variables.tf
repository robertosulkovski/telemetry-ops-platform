# Região AWS utilizada pelo TelemetryOps
variable "aws_region" {
  description = "Região AWS do projeto"
  type        = string
  default     = "us-east-1"
}

# Bloco de endereços da VPC
variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Bloco de endereços da subnet pública
variable "public_subnet_cidr" {
  description = "Bloco CIDR da subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

# Identificação do projeto
variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "telemetryops"
}

# IP público administrativo autorizado para acesso SSH
variable "admin_ip" {
  description = "IPv4 administrativo autorizado para SSH em formato CIDR"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_ip)) && try(split("/", var.admin_ip)[1] == "32", false)
    error_message = "Informe um IPv4 válido com máscara /32."
  }
}
