# 1. Generate a secure RSA private key
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Register the public key with AWS EC2
resource "aws_key_pair" "mpesa" {
  key_name   = "mpesa-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# 3. Save the private key to a local .pem file for SSH access
resource "local_file" "ssh_key" {
  filename        = "${path.module}/mpesa-key.pem"
  content         = tls_private_key.ec2_key.private_key_pem
  file_permission = "0400"
}

