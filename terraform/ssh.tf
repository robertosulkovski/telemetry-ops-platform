# Registra a chave pública SSH para acesso à instância EC2
resource "aws_key_pair" "telemetryops" {
  key_name   = "${var.project_name}-ec2-key"
  public_key = var.ssh_public_key
}
