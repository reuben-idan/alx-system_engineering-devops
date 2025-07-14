#!/usr/bin/env bash
# Sets up UFW to allow only 22, 80, 443 and configures port forwarding from 8080 to 80 on web-01

set -e

# Install UFW
sudo apt-get update
sudo apt-get install -y ufw

# Set UFW rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Enable forwarding in UFW config
sudo sed -i 's/^DEFAULT_FORWARD_POLICY=.*/DEFAULT_FORWARD_POLICY="ACCEPT"/' /etc/default/ufw

# Add port forwarding rule to before.rules if not already present
if ! grep -q "REDIRECT --to-port 80" /etc/ufw/before.rules; then
  sudo sed -i '/^*filter/i \
*nat\n:PREROUTING ACCEPT [0:0]\n-A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80\nCOMMIT\n' /etc/ufw/before.rules
fi

# Reload UFW to apply changes
sudo ufw reload

# Show UFW status
sudo ufw status verbose 