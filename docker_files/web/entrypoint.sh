#!/bin/bash
set -e

if [ -e /src/src/tmp/pids/server.pid ]; then
  rm -f /src/src/tmp/pids/server.pid
fi

exec "$@"
