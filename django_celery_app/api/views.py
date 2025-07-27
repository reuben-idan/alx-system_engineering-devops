from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .tasks import send_test_email


class PingView(APIView):
    """Simple ping endpoint returning service health."""

    def get(self, request, *args, **kwargs):
        # Trigger asynchronous test email via Celery
        email = request.query_params.get('email')
        if email:
            send_test_email.delay(email)
        return Response({'message': 'pong'}, status=status.HTTP_200_OK)
