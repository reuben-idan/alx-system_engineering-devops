# 0x0B. SSH

## Description

This project covers SSH (Secure Shell) configuration and key management for secure server connections. You will learn how to create SSH key pairs, configure SSH clients, and connect to remote Ubuntu servers using key-based authentication.

## Files

- `0-use_a_private_key`: Connects to a server using SSH and the private key ~/.ssh/school
- `1-create_ssh_key_pair`: Creates an RSA key pair named 'school' with 4096 bits and passphrase 'betty'
- `2-ssh_config`: SSH client configuration file for password-less authentication
- `3-let_me_in`: Adds a public key to the server's authorized_keys file

## Requirements

- Ubuntu 20.04 LTS
- RSA key pairs (4096 bits)
- Public key authentication
- SSH client configuration

## Learning Objectives

At the end of this project, you should be able to explain:

- What is a server and where servers usually live
- What is SSH and how it works
- How to create an SSH RSA key pair
- How to connect to a remote host using an SSH RSA key pair
- The advantage of using #!/usr/bin/env bash instead of /bin/bash

## Author

Reuben Idan

## Scripts

- **0-use_a_private_key**: Connects to server using private key authentication
- **1-create_ssh_key_pair**: Creates RSA key pair with specified parameters
- **2-ssh_config**: SSH client configuration file
- **setup.sh**: Automatic setup script (optional)

## Quick Setup

### Option 1: Automatic Setup

```bash
# Make setup script executable and run it
chmod +x setup.sh
./setup.sh
```

### Option 2: Manual Setup

1. **Make scripts executable:**

   ```bash
   chmod +x 0-use_a_private_key
   chmod +x 1-create_ssh_key_pair
   ```

2. **Create SSH key pair:**

   ```bash
   ./1-create_ssh_key_pair
   ```

   This will create:

   - `school` (private key)
   - `school.pub` (public key)

3. **Configure SSH client:**

   ```bash
   mkdir -p ~/.ssh
   cp 2-ssh_config ~/.ssh/config
   chmod 600 ~/.ssh/config
   ```

4. **Connect to server:**
   ```bash
   ./0-use_a_private_key
   ```

## Script Details

### 0-use_a_private_key

- Uses private key `~/.ssh/school`
- Connects to user `ubuntu` on IP `8.8.8.8`
- Uses single-character flags only

### 1-create_ssh_key_pair

- Creates RSA key with 4096 bits
- Names private key `school`
- Protects with passphrase `betty`

### 2-ssh_config

- Configures SSH to use private key authentication
- Disables password authentication
- Applies to all hosts

## Requirements Met

- ✅ All scripts use `#!/usr/bin/env bash` shebang
- ✅ All files end with newline
- ✅ Scripts are executable
- ✅ SSH configuration uses private key authentication only
- ✅ No use of `-l` flag
- ✅ Single-character flags only

## Testing

To test the connection:

```bash
# Test SSH connection
./0-use_a_private_key

# Expected output:
# ubuntu@server01:~$
# (You should be connected to your server)
```

## Troubleshooting

1. **Permission denied**: Make sure scripts are executable
2. **Key not found**: Run `./1-create_ssh_key_pair` first
3. **Connection refused**: Check if server IP is correct
4. **SSH config issues**: Verify `~/.ssh/config` permissions (600)

## Security Notes

- Private key (`school`) should be kept secure
- SSH config file should have 600 permissions
- .ssh directory should have 700 permissions
- Never share private keys
