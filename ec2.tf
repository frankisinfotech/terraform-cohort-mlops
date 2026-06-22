resource "aws_instance" "mpesa_vm" {
  count                   = 2
  ami                     = var.ami
  instance_type           = var.instance_type
  #  security_groups         = ["aws_security_group.allow_ssh"]
  vpc_security_group_ids  = [aws_security_group.allow_ssh.id]
  # subnet_id               = aws_subnet.mpesa_sub.id

  subnet_id               = aws_subnet.public[count.index % length(aws_subnet.public)].id


  key_name                = aws_key_pair.mpesa.key_name

  lifecycle {
      prevent_destroy         = false
    }

  tags = {
	Name = "mpesa_vms-${count.index}"
}
}


