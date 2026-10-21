
# Create Network ACL for Private Subnet
resource "aws_network_acl" "private_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.private.id]

  # Allow SSH from Public Subnet
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "172.20.1.0/24"
    from_port  = 22
    to_port    = 22
  }

  # Allow HTTP from Public Subnet
  ingress {
    rule_no    = 110
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "172.20.1.0/24"
    from_port  = 80
    to_port    = 80
  }

  # Allow Ephemeral Ports Inbound
  ingress {
    rule_no    = 120
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "172.20.1.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow Return Traffic to Public Subnet
  egress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "172.20.1.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "assignment-05-private-nacl"
  }
}
