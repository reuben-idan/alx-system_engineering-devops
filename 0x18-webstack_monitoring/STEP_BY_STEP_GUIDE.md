# Datadog Setup - Step-by-Step Execution Guide

## STEP 1: Create Application Key (Do this NOW)
1. On the current Datadog page (Application Keys), look for a "New Key" or "Create Application Key" button
2. Click it
3. Name it: "ALX Project Key"
4. Copy the generated application key and save it

## STEP 2: SSH to web-01 and Install Agent
Open your terminal and run these commands:

```bash
# Connect to web-01
ssh ubuntu@54.161.202.254

# Install Datadog Agent (run this on web-01)
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set correct hostname (run this on web-01)
sudo hostnamectl set-hostname XX-web-01

# Update Datadog agent configuration (run this on web-01)
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart Datadog agent (run this on web-01)
sudo systemctl restart datadog-agent

# Check agent status (run this on web-01)
sudo datadog-agent status
```

## STEP 3: Verify Installation
1. Go to https://app.datadoghq.com/infrastructure
2. Look for host named "XX-web-01"
3. It should appear within 5-10 minutes

## STEP 4: Copy Keys to Intranet Profile
Copy these values to your Intranet user profile:
- **Datadog API Key**: 7539ebebc75033fb4dc7c82d753bcb4a
- **Datadog Application Key**: [The one you created in Step 1]

## STEP 5: API Validation (Optional)
Replace YOUR_APPLICATION_KEY with the key from Step 1:
```bash
curl -X GET "https://api.datadoghq.com/api/v1/hosts" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: 7539ebebc75033fb4dc7c82d753bcb4a" \
-H "DD-APPLICATION-KEY: YOUR_APPLICATION_KEY"
```

## Troubleshooting
If hostname is incorrect:
```bash
sudo hostnamectl set-hostname XX-web-01
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml
sudo systemctl restart datadog-agent
```

If agent is not running:
```bash
sudo systemctl start datadog-agent
sudo systemctl enable datadog-agent
```

Check agent logs:
```bash
sudo tail -f /var/log/datadog/agent.log
```
