#!/bin/sh
set -e

PORT=${PORT:-8080}

# Prefer python3, then python2. If neither available, try busybox httpd.
if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  exec python -m SimpleHTTPServer "$PORT"
elif command -v busybox >/dev/null 2>&1; then
  exec busybox httpd -f -p "$PORT"
else
  echo "No supported static server found (python/busybox). Exiting."
  exit 1
fi
