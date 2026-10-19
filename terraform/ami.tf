# CSYE 6225 - Assignment 5
# Provided complete. Do not modify.
#
# Looks up the latest Ubuntu 22.04 LTS AMI in us-west-2, owned by
# Canonical. Both instances use this same AMI - no custom Packer image
# is needed for this assignment.

data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*22.04-amd64-server-*"]
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
