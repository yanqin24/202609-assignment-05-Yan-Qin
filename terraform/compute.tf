# CSYE 6225 - Assignment 5
# Provided complete. Do not modify.
#
# This file defines both EC2 instances. It references resources you will
# create in subnets.tf and security_groups.tf - see those files for the
# exact resource names this file expects:
#
#   aws_subnet.public              (subnets.tf)
#   aws_subnet.private             (subnets.tf)
#   aws_security_group.bastion_sg  (security_groups.tf)
#   aws_security_group.private_sg  (security_groups.tf)
#
# If Terraform can't find one of these, it means a resource name in your
# own files doesn't match what's expected here - check spelling exactly.

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/scripts/user_data.sh.tpl", {
    app_server_py = file("${path.module}/../app/server.py")
    host_role     = "public"
  })

  tags = {
    Name       = "assignment5-bastion"
    AssignedBy = "csye6225-assignment5"
  }
}

resource "aws_instance" "private" {
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/scripts/user_data.sh.tpl", {
    app_server_py = file("${path.module}/../app/server.py")
    host_role     = "private"
  })

  tags = {
    Name       = "assignment5-private"
    AssignedBy = "csye6225-assignment5"
  }
}
