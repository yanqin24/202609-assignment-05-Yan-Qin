#!/usr/bin/env python3
"""
CSYE 6225 - Assignment 5: VPC Networking with Terraform

Healthcheck service used on BOTH the public (bastion) and private hosts.

This uses only the Python standard library - no pip install required.
This is deliberate: the private host has no internet access in this
assignment (no NAT Gateway), so it cannot reach PyPI to install anything.
Since Ubuntu 22.04 ships with python3 pre-installed, this script runs
with zero setup beyond copying the file itself.

The bastion (HOST_ROLE=public) also exposes /check-private, which proxies
a request to a target host's /healthcheck. This is how Gradescope verifies
bastion -> private connectivity over plain HTTP, without needing SSH
access - see the assignment instructions for details.

Do NOT modify this file.
"""

import json
import os
import urllib.error
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs

HOST_ROLE = os.environ.get("HOST_ROLE", "unknown")
PORT = int(os.environ.get("PORT", 80))
PROXY_TIMEOUT_SECONDS = 5


class HealthcheckHandler(BaseHTTPRequestHandler):
    def _send_json(self, status_code, payload):
        body = json.dumps(payload).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        parsed = urlparse(self.path)

        if parsed.path == "/healthcheck":
            self._send_json(200, {"status": "ok", "host": HOST_ROLE})
            return

        if parsed.path == "/check-private":
            if HOST_ROLE != "public":
                # Only the bastion proxies to another host.
                self.send_response(404)
                self.end_headers()
                return

            target = parse_qs(parsed.query).get("target", [None])[0]
            if not target:
                self._send_json(400, {"error": "missing required query parameter: target"})
                return

            try:
                url = f"http://{target}/healthcheck"
                with urllib.request.urlopen(url, timeout=PROXY_TIMEOUT_SECONDS) as resp:
                    body = resp.read()
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Content-Length", str(len(body)))
                self.end_headers()
                self.wfile.write(body)
            except (urllib.error.URLError, TimeoutError, ConnectionError) as exc:
                self._send_json(502, {"error": f"could not reach {target}: {exc}"})
            return

        self.send_response(404)
        self.end_headers()

    def log_message(self, format, *args):
        # Quiet down default stderr logging; systemd captures this either way.
        pass


if __name__ == "__main__":
    server = ThreadingHTTPServer(("0.0.0.0", PORT), HealthcheckHandler)
    server.serve_forever()
