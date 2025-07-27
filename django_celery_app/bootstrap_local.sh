#!/usr/bin/env bash
# Local bootstrap script to run app + celery
PROJECT_DIR="$(dirname "$0")"
cd "$PROJECT_DIR" || exit 1
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 0.0.0.0:8000 &
celery -A django_celery_app worker -l info
