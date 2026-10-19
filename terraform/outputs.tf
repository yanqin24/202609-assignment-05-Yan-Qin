# CSYE 6225 - Assignment 5
# Provided complete. Do not modify.
#
# Gradescope reads these values directly from your committed
# terraform.tfstate to run its live checks.

output "bastion_public_ip" {
  description = "Public IP address of the bastion (public) host"
  value       = aws_instance.bastion.public_ip
}

output "private_instance_ip" {
  description = "Private IP address of the private host"
  value       = aws_instance.private.private_ip
}
