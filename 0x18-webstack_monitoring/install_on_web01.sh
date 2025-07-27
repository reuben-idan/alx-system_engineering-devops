#!/bin/bash
# Automated Datadog Agent Installation Script for web-01
# Run this script on web-01 server after SSH connection

set -e  # Exit on any error

echo "=== Datadog Agent Installation on web-01 ==="
echo "Starting installation process..."

# Install Datadog Agent
echo "Step 1: Installing Datadog Agent..."
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

if [ $? -eq 0 ]; then
    echo "✅ Datadog Agent installed successfully!"
else
    echo "❌ Failed to install Datadog Agent"
    exit 1
fi

# Set hostname to XX-web-01
echo "Step 2: Setting hostname to XX-web-01..."
sudo hostnamectl set-hostname XX-web-01

if [ $? -eq 0 ]; then
    echo "✅ Hostname set to XX-web-01"
else
    echo "❌ Failed to set hostname"
    exit 1
fi

# Update Datadog agent configuration
echo "Step 3: Updating Datadog agent configuration..."
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

if [ $? -eq 0 ]; then
    echo "✅ Datadog configuration updated"
else
    echo "❌ Failed to update Datadog configuration"
    exit 1
fi

# Restart Datadog agent
echo "Step 4: Restarting Datadog agent..."
sudo systemctl restart datadog-agent

if [ $? -eq 0 ]; then
    echo "✅ Datadog agent restarted successfully"
else
    echo "❌ Failed to restart Datadog agent"
    exit 1
fi

# Enable Datadog agent to start on boot
echo "Step 5: Enabling Datadog agent to start on boot..."
sudo systemctl enable datadog-agent

# Wait a moment for the agent to start
echo "Waiting for agent to start..."
sleep 10

# Check agent status
echo "Step 6: Checking Datadog agent status..."
sudo datadog-agent status

echo ""
echo "=== Installation Complete! ==="
echo "Your server should now be visible in Datadog as 'XX-web-01'"
echo "Check: https://app.datadoghq.com/infrastructure"
echo ""
echo "API Key: 7539ebebc75033fb4dc7c82d753bcb4a"
echo "Remember to create an Application Key in Datadog and copy both keys to your Intranet profile"
