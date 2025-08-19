# Deploying to Render.com

This guide will help you deploy the ALX Webstack Monitoring dashboard to Render.com.

## Prerequisites

1. A Render.com account (sign up at [https://render.com](https://render.com) if you don't have one)
2. A Datadog account with API and Application keys

## Deployment Steps

1. **Fork this repository** to your GitHub account

2. **Sign in to Render.com** and click "New +" then select "Web Service"

3. **Connect your GitHub repository**
   - Select the forked repository
   - Choose a name for your service (e.g., "alx-webstack-monitoring")
   - Select "Python" as the runtime
   - Choose a region closest to you
   - Select the free instance type

4. **Configure environment variables**
   - `PYTHON_VERSION`: 3.9.0
   - `DD_API_KEY`: Your Datadog API Key
   - `DD_APP_KEY`: Your Datadog Application Key

5. **Deploy**
   - Click "Create Web Service"
   - Render will automatically build and deploy your application

6. **Access your dashboard**
   - Once deployed, you'll get a URL like `https://your-service-name.onrender.com`
   - Visit this URL to access your monitoring dashboard

## Updating the Dashboard

Push changes to your GitHub repository, and Render will automatically redeploy your application.

## Security Notes

- Keep your Datadog API and Application keys secure
- Use environment variables instead of hardcoding sensitive information
- Consider setting up authentication for the dashboard in a production environment
