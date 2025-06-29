#!/usr/bin/env bash
# Automatic setup script for SSH project

echo "Setting up SSH project..."

# Make all scripts executable
echo "Making scripts executable..."
chmod +x 0-use_a_private_key
chmod +x 1-create_ssh_key_pair

# Create .ssh directory if it doesn't exist
echo "Setting up .ssh directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copy SSH config file
echo "Configuring SSH client..."
cp 2-ssh_config ~/.ssh/config
chmod 600 ~/.ssh/config

# Create SSH key pair
echo "Creating SSH key pair..."
./1-create_ssh_key_pair

echo "Setup complete!"
echo "You can now use: ./0-use_a_private_key" 