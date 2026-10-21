
# 1. Security Group for Bastion EC2
resource "aws_security_group" "bastion_sg" {
  name        = "assignment-05-bastion-sg"
  description = "Security group for public bastion host"
  vpc_id      = aws_vpc.main.id

  # Allow SSH from the Internet
  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP from the Internet
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH to private subnet
  egress {
    description = "SSH to private subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.20.2.0/24"]
  }

  # Allow HTTP to private subnet
  egress {
    description = "HTTP to private subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.20.2.0/24"]
  }

  tags = {
    Name = "assignment-05-bastion-sg"
  }
}

# 2. Security Group for Private EC2
resource "aws_security_group" "private_sg" {
  name        = "assignment-05-private-sg"
  description = "Security group for private host"
  vpc_id      = aws_vpc.main.id

  # Allow SSH only from Bastion
  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow HTTP only from Bastion
  ingress {
    description     = "HTTP from Bastion"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # No outbound rules: private host cannot initiate connections

  tags = {
    Name = "assignment-05-private-sg"
  }
}

