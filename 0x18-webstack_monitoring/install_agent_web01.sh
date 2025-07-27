#!/bin/bash
# ALX 0x18-webstack_monitoring - Datadog Agent Installation for web-01
# Run this script directly on web-01 server

set -e

echo "=== ALX Datadog Agent Installation on web-01 ==="
echo "Starting installation process..."

# Configuration
DD_API_KEY="7539ebebc75033fb4dc7c82d753bcb4a"
DD_SITE="datadoghq.com"
TARGET_HOSTNAME="XX-web-01"

# Step 1: Install Datadog Agent
echo "Step 1: Installing Datadog Agent..."
DD_API_KEY=$DD_API_KEY DD_SITE=$DD_SITE bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

if [ $? -eq 0 ]; then
    echo "✅ Datadog Agent installed successfully!"
else
    echo "❌ Failed to install Datadog Agent"
    exit 1
fi

# Step 2: Set hostname to XX-web-01
echo "Step 2: Setting hostname to $TARGET_HOSTNAME..."
sudo hostnamectl set-hostname $TARGET_HOSTNAME

if [ $? -eq 0 ]; then
    echo "✅ Hostname set to $TARGET_HOSTNAME"
else
    echo "❌ Failed to set hostname"
    exit 1
fi

# Step 3: Update Datadog agent configuration
echo "Step 3: Updating Datadog agent configuration..."
sudo sed -i "s/# hostname:.*/hostname: $TARGET_HOSTNAME/" /etc/datadog-agent/datadog.yaml

if [ $? -eq 0 ]; then
    echo "✅ Datadog configuration updated"
else
    echo "❌ Failed to update Datadog configuration"
    exit 1
fi

# Step 4: Restart Datadog agent
echo "Step 4: Restarting Datadog agent..."
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

if [ $? -eq 0 ]; then
    echo "✅ Datadog agent restarted and enabled"
else
    echo "❌ Failed to restart Datadog agent"
    exit 1
fi

# Step 5: Verify installation
echo "Step 5: Verifying installation..."
sleep 10  # Wait for agent to start

echo "Checking agent status..."
sudo datadog-agent status | head -20

echo "Verifying hostname..."
hostname

echo "Checking if agent is running..."
sudo systemctl status datadog-agent --no-pager

echo ""
echo "=== Installation Complete ==="
echo "✅ Datadog Agent installed on web-01"
echo "✅ Hostname set to: $TARGET_HOSTNAME"
echo "✅ Agent configured and running"
echo ""
echo "Next steps:"
echo "1. Verify server appears in Datadog Infrastructure: https://app.datadoghq.com/infrastructure"
echo "2. Create monitors for disk I/O metrics"
echo "3. Verify dashboard is working"
echo ""
echo "Server should appear as '$TARGET_HOSTNAME' in Datadog within 5-10 minutes."
