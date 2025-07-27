#!/bin/bash
# Datadog Agent Installation Script for web-01
# This script installs the Datadog agent on Ubuntu/Debian systems

# Your Datadog API Key
DD_API_KEY="7539ebebc75033fb4dc7c82d753bcb4a"
DD_SITE="datadoghq.com"

echo "Installing Datadog Agent on web-01..."
echo "API Key: $DD_API_KEY"
echo "Site: $DD_SITE"

# Install the Datadog Agent
DD_API_KEY=$DD_API_KEY \
DD_SITE="$DD_SITE" \
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "Datadog Agent installed successfully!"
    
    # Set hostname to XX-web-01 as required
    echo "Setting hostname to XX-web-01..."
    sudo hostnamectl set-hostname XX-web-01
    
    # Update the Datadog agent configuration with the correct hostname
    sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml
    
    # Restart the Datadog agent to apply changes
    sudo systemctl restart datadog-agent
    
    # Check agent status
    sudo datadog-agent status
    
    echo "Installation complete! Your server should now be visible in Datadog as XX-web-01"
else
    echo "Installation failed. Please check the error messages above."
    exit 1
fi
