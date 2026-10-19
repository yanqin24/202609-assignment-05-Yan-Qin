# CSYE 6225 - Assignment 5
# YOUR WORK: Complete this file.
#
# Requirements:
#
# 1. aws_vpc "main": CIDR block 172.20.0.0/16. Enable DNS support and
#    DNS hostnames (both should be true).
#
# 2. aws_internet_gateway "main": attached to your VPC.
#
# 3. aws_route_table "public": associated with your VPC.
#    - A local route to 172.20.0.0/16 is created automatically - you
#      don't need to add it yourself.
#    - Add a route: 0.0.0.0/0 -> your Internet Gateway.
#
# 4. aws_route_table "private": associated with your VPC.
#    - Do NOT add a 0.0.0.0/0 route here. The private subnet must have
#      no path to the internet at all - that's the entire point of
#      this assignment's isolation model.
#
# 5. aws_route_table_association resources connecting:
#    - Your public route table to aws_subnet.public (defined in subnets.tf)
#    - Your private route table to aws_subnet.private (defined in subnets.tf)
#
# Resource names compute.tf and nacls.tf expect from this file:
#   aws_vpc.main
#   aws_internet_gateway.main
#   aws_route_table.public
#   aws_route_table.private
