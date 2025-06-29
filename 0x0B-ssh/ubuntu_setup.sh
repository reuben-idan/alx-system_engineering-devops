#!/bin/bash
# SSH Project Setup Script for Ubuntu
# This script will set up your SSH key pair and configuration

echo "🚀 SSH Project Setup Script"
echo "=========================="

# Check if we're on Ubuntu
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "❌ This script is designed for Ubuntu/Linux systems"
    echo "Please run this on your Ubuntu server or WSL"
    exit 1
fi

# Step 1: Generate SSH key pair
echo "📝 Step 1: Generating SSH key pair..."
if [ -f "1-create_ssh_key_pair" ]; then
    chmod +x 1-create_ssh_key_pair
    ./1-create_ssh_key_pair
    echo "✅ SSH key pair generated successfully"
else
    echo "❌ 1-create_ssh_key_pair script not found"
    exit 1
fi

# Step 2: Create SSH directory if it doesn't exist
echo "📁 Step 2: Setting up SSH directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Step 3: Move private key to SSH directory
echo "🔐 Step 3: Moving private key to secure location..."
if [ -f "school" ]; then
    mv school ~/.ssh/
    chmod 600 ~/.ssh/school
    echo "✅ Private key moved to ~/.ssh/school"
else
    echo "❌ Private key 'school' not found"
    exit 1
fi

# Step 4: Set up SSH configuration
echo "⚙️  Step 4: Setting up SSH configuration..."
if [ -f "2-ssh_config" ]; then
    cp 2-ssh_config ~/.ssh/config
    chmod 600 ~/.ssh/config
    echo "✅ SSH configuration set up"
else
    echo "❌ 2-ssh_config file not found"
    exit 1
fi

# Step 5: Make connection script executable
echo "🔗 Step 5: Setting up connection script..."
if [ -f "0-use_a_private_key" ]; then
    chmod +x 0-use_a_private_key
    echo "✅ Connection script made executable"
else
    echo "❌ 0-use_a_private_key script not found"
    exit 1
fi

# Step 6: Make task 3 script executable
echo "🔑 Step 6: Setting up task 3 script..."
if [ -f "3-let_me_in" ]; then
    chmod +x 3-let_me_in
    echo "✅ Task 3 script made executable"
else
    echo "❌ 3-let_me_in script not found"
    exit 1
fi

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "📋 Next Steps:"
echo "1. Get your server IP from ALX intranet 'My Servers' section"
echo "2. Edit 0-use_a_private_key and replace <IP_ADDRESS> with your server IP"
echo "3. Add your public key to the server:"
echo "   ssh-copy-id -i school.pub ubuntu@<YOUR_SERVER_IP>"
echo "4. Test connection: ./0-use_a_private_key"
echo "5. SSH to server and run: ./3-let_me_in"
echo ""
echo "📁 Files created:"
echo "- Private key: ~/.ssh/school"
echo "- Public key: school.pub"
echo "- SSH config: ~/.ssh/config"
echo ""
echo "🔐 Security: All files have proper permissions set" 