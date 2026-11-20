# Busca a AMI oficial do Ubuntu Server 24.04 LTS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Cria a instância EC2 do TelemetryOps
resource "aws_instance" "telemetryops" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "m7i-flex.large"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.telemetryops.id]
  key_name                    = aws_key_pair.telemetryops.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true

    tags = {
      Name = "${var.project_name}-root-volume"
    }
  }

  tags = {
    Name        = "${var.project_name}-ec2"
    Environment = "lab"
    Project     = "TelemetryOps"
  }
}
