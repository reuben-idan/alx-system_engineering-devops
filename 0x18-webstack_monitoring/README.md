# Datadog Monitoring Setup

This directory contains the setup for Datadog monitoring on web-01 server.

## Server Information
- **WEB01_IP**: 54.161.202.254
- **WEB02_IP**: 52.23.248.46  
- **WEB03_IP**: 54.164.58.71

## Datadog Account Details
- **API Key**: 7539ebebc75033fb4dc7c82d753bcb4a
- **Site**: datadoghq.com (US1 region)
- **Account URL**: https://app.datadoghq.com

## Installation Steps

### 1. Connect to web-01 server
```bash
ssh ubuntu@54.161.202.254
```

### 2. Run the installation script
Copy the `install_datadog_agent.sh` script to web-01 and execute:
```bash
chmod +x install_datadog_agent.sh
sudo ./install_datadog_agent.sh
```

### 3. Verify installation
After installation, verify the agent is running:
```bash
sudo datadog-agent status
```

### 4. Check hostname
Ensure the hostname is set correctly:
```bash
hostname
# Should show: XX-web-01
```

### 5. Create Application Key
1. Go to https://app.datadoghq.com/organization-settings/application-keys
2. Click "New Key"
3. Give it a name (e.g., "ALX Project Key")
4. Copy the generated application key

### 6. Verify server visibility
1. Go to https://app.datadoghq.com/infrastructure
2. Look for host named "XX-web-01"
3. It should appear within 5-10 minutes after installation

### 7. API Validation
Use this API endpoint to validate your setup:
```bash
curl -X GET "https://api.datadoghq.com/api/v1/hosts" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: 7539ebebc75033fb4dc7c82d753bcb4a" \
-H "DD-APPLICATION-KEY: YOUR_APPLICATION_KEY"
```

## Troubleshooting

### If hostname is incorrect:
```bash
sudo hostnamectl set-hostname XX-web-01
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml
sudo systemctl restart datadog-agent
```

### If agent is not running:
```bash
sudo systemctl start datadog-agent
sudo systemctl enable datadog-agent
```

### Check agent logs:
```bash
sudo tail -f /var/log/datadog/agent.log
```

## Required Actions for Intranet Profile
Copy these values to your Intranet user profile:
- **Datadog API Key**: 7539ebebc75033fb4dc7c82d753bcb4a
- **Datadog Application Key**: [To be generated in step 5]
