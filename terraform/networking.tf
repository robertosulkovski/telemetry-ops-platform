# Cria a subnet pública do TelemetryOps
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.telemetryops.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}

# Cria o Internet Gateway para permitir conectividade com a internet
resource "aws_internet_gateway" "telemetryops" {
  vpc_id = aws_vpc.telemetryops.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}

# Cria a tabela de rotas da subnet pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.telemetryops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.telemetryops.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}

# Associa a tabela de rotas pública à subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Cria o Security Group da instância TelemetryOps
resource "aws_security_group" "telemetryops" {
  name        = "${var.project_name}-sg"
  description = "Controla o acesso à instância TelemetryOps"
  vpc_id      = aws_vpc.telemetryops.id

  # Permite SSH somente a partir do IP administrativo
  ingress {
    description = "Acesso administrativo SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # Permite acesso HTTP à aplicação
  ingress {
    description = "Acesso HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite acesso HTTPS à aplicação
  ingress {
    description = "Acesso HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite tráfego de saída da instância
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}

