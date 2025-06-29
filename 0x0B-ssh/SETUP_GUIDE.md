# SSH Project Setup Guide

## Overview

This guide will help you set up SSH key-based authentication to connect to your Ubuntu server (103900-web-01).

## Prerequisites

- Your server IP address from the "My Servers" section of the intranet
- Ubuntu 20.04 LTS environment (your local machine or WSL)

## Step-by-Step Setup

### Step 1: Generate the SSH Key Pair

1. Make the script executable:

   ```bash
   chmod +x 1-create_ssh_key_pair
   ```

2. Run the script to generate your key pair:
   ```bash
   ./1-create_ssh_key_pair
   ```
   - This creates `school` (private key) and `school.pub` (public key)
   - The passphrase is "betty"

### Step 2: Set Up SSH Configuration

1. Copy the SSH config to the proper location:

   ```bash
   cp 2-ssh_config ~/.ssh/config
   chmod 600 ~/.ssh/config
   ```

2. Move your private key to the SSH directory:
   ```bash
   mv school ~/.ssh/
   chmod 600 ~/.ssh/school
   ```

### Step 3: Add Your Public Key to the Server

1. Copy your public key to the server:
   ```bash
   ssh-copy-id -i school.pub ubuntu@<YOUR_SERVER_IP>
   ```
   - Replace `<YOUR_SERVER_IP>` with your actual server IP

### Step 4: Test the Connection

1. Make the connection script executable:

   ```bash
   chmod +x 0-use_a_private_key
   ```

2. Update the script with your server IP:

   ```bash
   # Edit 0-use_a_private_key and replace <IP_ADDRESS> with your server IP
   ```

3. Test the connection:
   ```bash
   ./0-use_a_private_key
   ```

### Step 5: Add the Provided Public Key (Task 3)

1. SSH into your server:

   ```bash
   ssh -i ~/.ssh/school ubuntu@<YOUR_SERVER_IP>
   ```

2. Run the script to add the provided public key:

   ```bash
   chmod +x 3-let_me_in
   ./3-let_me_in
   ```

3. Set proper permissions:
   ```bash
   chmod 600 ~/.ssh/authorized_keys
   ```

## File Locations

- Private key: `~/.ssh/school`
- Public key: `school.pub` (in project directory)
- SSH config: `~/.ssh/config`
- Server authorized_keys: `~/.ssh/authorized_keys` (on server)

## Troubleshooting

- If connection fails, check that your public key is properly added to the server
- Ensure file permissions are correct (600 for private keys)
- Verify the server IP address is correct
- Check that the SSH service is running on the server

## Security Notes

- Keep your private key secure and never share it
- Use a strong passphrase for additional security
- Regularly rotate your keys
- Monitor server access logs
