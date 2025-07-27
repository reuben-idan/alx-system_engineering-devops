#!/usr/bin/env bash
# Start Celery worker on PythonAnywhere Always-on task
cd "$(dirname "$0")" || exit 1
source venv/bin/activate 2>/dev/null || true
exec celery -A django_celery_app worker -l info
