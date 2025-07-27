#!/usr/bin/env bash
# Complete Datadog setup script for ALX project 0x18-webstack_monitoring

set -e

echo "=== ALX 0x18-webstack_monitoring Complete Setup ==="

# Configuration
DD_API_KEY="7539ebebc75033fb4dc7c82d753bcb4a"
DD_SITE="datadoghq.com"
HOSTNAME="XX-web-01"

# Task 0: Install Datadog Agent
echo "Task 0: Installing Datadog Agent..."
if ! command -v datadog-agent &> /dev/null; then
    echo "Installing Datadog Agent..."
    DD_API_KEY=$DD_API_KEY DD_SITE=$DD_SITE bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
    echo "✅ Datadog Agent installed"
else
    echo "✅ Datadog Agent already installed"
fi

# Set hostname
echo "Setting hostname to $HOSTNAME..."
sudo hostnamectl set-hostname $HOSTNAME
echo "✅ Hostname set to $HOSTNAME"

# Update Datadog configuration
echo "Updating Datadog configuration..."
sudo sed -i "s/# hostname:.*/hostname: $HOSTNAME/" /etc/datadog-agent/datadog.yaml
echo "✅ Datadog configuration updated"

# Restart and verify agent
echo "Restarting Datadog agent..."
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent
echo "✅ Datadog agent restarted and enabled"

# Check agent status
echo "Checking agent status..."
sudo datadog-agent status | head -20
echo "✅ Agent status checked"

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Verify server appears in Datadog as '$HOSTNAME'"
echo "2. Create monitors for disk read/write requests"
echo "3. Create dashboard with 4+ widgets"
echo "4. Save dashboard ID to 2-setup_datadog file"
echo ""
echo "Datadog Dashboard: https://app.datadoghq.com"
