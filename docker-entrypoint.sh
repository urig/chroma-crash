#!/bin/sh

set -e  # exit on non-0 exit code

. .venv/bin/activate

# exec gunicorn --bind 0.0.0.0:8080 --forwarded-allow-ips='*' "chat_api.app:create_app()"

exec flask --app chroma_crash.app run --debug
