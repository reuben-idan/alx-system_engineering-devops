from flask import Flask, render_template_string, jsonify
import os
from datadog import initialize, api

app = Flask(__name__)

# Initialize Datadog
initialize(
    api_key=os.getenv('DD_API_KEY'),
    app_key=os.getenv('DD_APP_KEY')
)

@app.route('/')
def dashboard():
    """Render the main dashboard page"""
    return render_template_string("""
    <!DOCTYPE html>
    <html>
    <head>
        <title>ALX Webstack Monitoring</title>
        <script src="https://www.datadoghq-browser-agent.com/datadog-logs-us.js"></script>
        <script>
            DD_LOGS.init({
                clientToken: 'pub7539ebebc75033fb4dc7c82d753bcb4a',
                site: 'datadoghq.com',
                forwardErrorsToLogs: true,
                sampleRate: 100,
            });
        </script>
        <style>
            body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
            .container { max-width: 1200px; margin: 0 auto; }
            .dashboard { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 20px; }
            iframe { width: 100%; height: 600px; border: 1px solid #ddd; border-radius: 4px; }
            h1 { color: #632ca6; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>ALX Webstack Monitoring Dashboard</h1>
            <div class="dashboard">
                <iframe src="https://app.datadoghq.com/dashboard/embed?from_ts=now-24h&to_ts=now&live=true" frameborder="0"></iframe>
                <iframe src="https://app.datadoghq.com/monitors/manage?q=status:alert" frameborder="0"></iframe>
            </div>
        </div>
    </body>
    </html>
    """)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
