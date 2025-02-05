#!/bin/bash
set -e
rm -f /cofee_app/tmp/pids/server.pid
exec "$@"