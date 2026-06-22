locals {
   ports = [22, 80, 90, 443, 100, 160]
 }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.mpesa_vpc.id

  dynamic "ingress" {
    for_each = toset(local.ports)

    content {
      description   = "allow custom port numbers"
      from_port     = ingress.value
      to_port       = ingress.value
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-ports-sg"
  }
}

#resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
#  security_group_id = aws_security_group.allow_ssh.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 22
#  ip_protocol       = "tcp"
#  to_port           = 8080
#}

#resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#  security_group_id = aws_security_group.allow_ssh.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1" # semantically equivalent to all ports
#}
