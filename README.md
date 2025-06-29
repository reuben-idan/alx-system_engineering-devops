# ALX System Engineering & DevOps

This repository contains projects and scripts for the ALX System Engineering & DevOps program.

## Projects

### 0x03-shell_variables_expansions

Shell scripting with variables, expansions, and arithmetic operations.

### 0x09-web_infrastructure_design

Web infrastructure design projects covering simple, distributed, secured, and scaled architectures.

### 0x0B-ssh

SSH configuration and key management for secure server connections.

## SSH Project (0x0B-ssh)

This project covers SSH (Secure Shell) configuration and key management for secure server connections.

### Scripts

- **0-use_a_private_key**: Connects to server using private key authentication
- **1-create_ssh_key_pair**: Creates RSA key pair with specified parameters
- **2-ssh_config**: SSH client configuration file

### Requirements

- All scripts use `#!/usr/bin/env bash` shebang
- All files end with a new line
- Scripts are executable
- SSH configuration uses private key authentication only

### Usage

1. Create SSH key pair:

   ```bash
   ./1-create_ssh_key_pair
   ```

2. Configure SSH client:

   ```bash
   cp 2-ssh_config ~/.ssh/config
   ```

3. Connect to server:
   ```bash
   ./0-use_a_private_key
   ```

## Learning Objectives

- Understanding SSH and secure connections
- RSA key pair generation and management
- SSH client configuration
- Server authentication methods
