# CSYE 6225 - Assignment 5
# YOUR WORK: Complete this file.
#
# Requirements:
#
# 1. aws_security_group "bastion_sg" (used by the public/bastion host):
#    Inbound:
#      - SSH (22) from 0.0.0.0/0
#      - HTTP (80) from 0.0.0.0/0
#    Outbound:
#      - Allow SSH (22) and HTTP (80) to the private subnet's CIDR block
#        (172.20.2.0/24).
#      - Do NOT reference aws_security_group.private_sg here. Since
#        private_sg's inbound rule (below) already references bastion_sg,
#        referencing private_sg back from here would create a circular
#        dependency between the two security groups - Terraform needs
#        each one to exist before it can create the other, and
#        `terraform apply` will fail with a cycle error. Using the
#        subnet CIDR for this one direction avoids the cycle.
#
# 2. aws_security_group "private_sg" (used by the private host):
#    Inbound:
#      - SSH (22) from the bastion's Security Group only
#        (reference aws_security_group.bastion_sg, not a CIDR block)
#      - HTTP (80) from the bastion's Security Group only
#    Outbound:
#      - Think carefully about whether this instance ever initiates a
#        connection anywhere. If it doesn't need to, it doesn't need an
#        egress rule at all - Security Groups are stateful, so replies
#        to inbound connections don't require a matching egress rule.
#
# Both security groups must be attached to your VPC (aws_vpc.main).
#
# Resource names compute.tf and nacls.tf expect from this file:
#   aws_security_group.bastion_sg
#   aws_security_group.private_sg
