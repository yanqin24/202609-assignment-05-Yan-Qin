# CSYE 6225 - Assignment 5
# YOUR WORK: Complete this file.
#
# A custom NACL is required on the PRIVATE subnet only. The public subnet
# stays on its default NACL (which allows all traffic) - the interesting
# part of this exercise is scoping the private subnet's NACL correctly,
# so that's the one you write here.
#
# Remember: NACLs are stateless - unlike Security Groups, you must
# explicitly allow return traffic on ephemeral ports (1024-65535), or
# connections will hang rather than fail outright.
#
# aws_network_acl "private_nacl" (associated with aws_subnet.private):
#   Inbound:
#     - SSH (22) from the public subnet's CIDR (172.20.1.0/24)
#     - HTTP (80) from the public subnet's CIDR (172.20.1.0/24)
#     - Ephemeral ports (1024-65535) from the public subnet's CIDR
#   Outbound:
#     - Ephemeral ports (1024-65535) to the public subnet's CIDR
#       (responses to the bastion's SSH/HTTP requests)
#     - No route to 0.0.0.0/0 is needed or expected - the private host
#       never initiates outbound traffic to the internet.
#
# Remember to use explicit rule numbers, and to associate the NACL with
# aws_subnet.private.
#
# Resource name this assignment expects:
#   aws_network_acl.private_nacl
