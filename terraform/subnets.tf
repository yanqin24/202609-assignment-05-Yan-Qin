# CSYE 6225 - Assignment 5
# YOUR WORK: Complete this file.
#
# Requirements:
#
# 1. aws_subnet "public":
#    - vpc_id: your VPC (aws_vpc.main, from network.tf)
#    - cidr_block: 172.20.1.0/24
#    - availability_zone: us-west-2a
#    - map_public_ip_on_launch: true (instances launched here get a
#      public IP automatically)
#
# 2. aws_subnet "private":
#    - vpc_id: your VPC
#    - cidr_block: 172.20.2.0/24
#    - availability_zone: us-west-2a
#    - map_public_ip_on_launch: false
#
# Resource names compute.tf, network.tf, and nacls.tf expect from this file:
#   aws_subnet.public
#   aws_subnet.private
