# Cria a rede virtual isolada do projeto TelemetryOps
resource "aws_vpc" "telemetryops" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}
