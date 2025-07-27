import os, sys
from pathlib import Path

# Add project path
BASE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = BASE_DIR / 'django_celery_app'
if str(PROJECT_DIR) not in sys.path:
    sys.path.insert(0, str(BASE_DIR))

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_celery_app.settings')

from django.core.wsgi import get_wsgi_application  # noqa: E402
application = get_wsgi_application()
