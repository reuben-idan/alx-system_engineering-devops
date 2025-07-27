from django.core.mail import send_mail
from django.conf import settings
from celery import shared_task


@shared_task
def send_test_email(recipient: str):
    """Send a simple test email asynchronously."""
    subject = "Django Celery Test Email"
    message = "This is a test email sent asynchronously via Celery and CloudAMQP."
    from_email = settings.DEFAULT_FROM_EMAIL
    send_mail(subject, message, from_email, [recipient], fail_silently=True)
