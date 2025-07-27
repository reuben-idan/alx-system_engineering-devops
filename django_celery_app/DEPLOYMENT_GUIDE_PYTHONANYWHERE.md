# Deploying Django Celery App to PythonAnywhere

Follow these steps after pushing code to GitHub.

## 1. Create PythonAnywhere account & app
1. Log in, go to **Web** tab → **Add a new web app**.
2. Choose **Manual Configuration**, Python 3.11.
3. Set **Source code** to your repo (clone via `bash` console):
```bash
cd ~
git clone https://github.com/<your-username>/<repo>.git
```
4. Set **Working directory** in web app settings to `~/repo/django_celery_app`.

## 2. Virtualenv & requirements
```bash
python -m venv ~/venv
source ~/venv/bin/activate
pip install -r django_celery_app/requirements.txt
```
Point the web app **Virtualenv** field to `~/venv`.

## 3. WSGI configuration
Edit the WSGI file path to point to `pa_wsgi.py`:
```python
# in /var/www/<username>_pythonanywhere_com_wsgi.py
import os, sys
path = '/home/<username>/repo/django_celery_app'
if path not in sys.path:
    sys.path.insert(0, path)
from pa_wsgi import application  # app object
```
(Or simply set "WSGI file" to `~/repo/django_celery_app/pa_wsgi.py` in UI.)

## 4. Environment variables
In **Web → Environment Variables** add:
```
SECRET_KEY=<secure value>
DEBUG=False
ALLOWED_HOSTS=<username>.pythonanywhere.com
CLOUDAMQP_URL=amqps://user:pass@rabbit.rmq.cloudamqp.com/vhost
EMAIL_HOST=...
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=...
EMAIL_HOST_PASSWORD=...
DEFAULT_FROM_EMAIL=webmaster@example.com
```

## 5. Database & static files
```bash
cd ~/repo/django_celery_app
python manage.py migrate
python manage.py collectstatic --noinput
```
Configure **Static files**: URL `/static/` → `~/repo/django_celery_app/staticfiles`.

## 6. Celery worker (Always-on task)
Go to **Tasks → Always-on Tasks** and add:
```
cd ~/repo/django_celery_app && bash start_celery.sh
```

## 7. Reload web app
Click **Reload**. Visit `https://<username>.pythonanywhere.com/swagger/` — you should see the docs.

Hit `https://<host>/api/ping/?email=you@example.com` to test Celery email.

## 8. Updating code
```bash
cd ~/repo
git pull
workon venv
pip install -r django_celery_app/requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
reload
```

---
Enjoy your Django + Celery app on PythonAnywhere!
