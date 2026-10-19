#!/bin/bash
# CSYE 6225 - Assignment 5
# Provided complete - do not modify.
#
# This script is templated by Terraform (see compute.tf) and used for
# BOTH the public and private instances, with different values for
# host_role. It requires no internet access: server.py uses only the
# Python standard library, and python3 ships pre-installed on the
# Ubuntu 22.04 AMI used by this assignment.
#
# Gradescope verifies bastion -> private connectivity over plain HTTP
# via server.py's /check-private endpoint - no SSH access is needed for
# grading. You can still SSH in yourself using your own EC2 key pair
# (key_name) for manual testing and debugging.

set -e

mkdir -p /opt/healthcheck
cat > /opt/healthcheck/server.py << 'PYEOF'
${app_server_py}
PYEOF

cat > /etc/systemd/system/healthcheck.service << EOF
[Unit]
Description=CSYE 6225 Healthcheck Service
After=network.target

[Service]
Environment=HOST_ROLE=${host_role}
Environment=PORT=80
ExecStart=/usr/bin/python3 /opt/healthcheck/server.py
Restart=on-failure
User=root
WorkingDirectory=/opt/healthcheck

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable healthcheck.service
systemctl start healthcheck.service
