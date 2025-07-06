# Web Server Project

This project focuses on web server configuration and automation using Bash scripts.

## Tasks

### 0. Transfer a file to your server

- **File**: `0-transfer_file`
- **Description**: Bash script that transfers a file from client to server using scp
- **Requirements**:
  - Accepts 4 parameters: file path, IP, username, SSH key path
  - Displays usage message if less than 4 parameters
  - Transfers file to user home directory
  - Disables strict host key checking

### 1. Install nginx web server

- **File**: `1-install_nginx_web_server`
- **Description**: Bash script that installs and configures nginx
- **Requirements**:
  - Installs nginx on web-01 server
  - Nginx listens on port 80
  - Returns "Hello World!" when querying root with GET request
  - Uses `-y` flag on apt-get commands
  - No systemctl for restarting nginx

### 2. Setup a domain name

- **File**: `2-setup_a_domain_name`
- **Description**: Contains domain name for .TECH domain setup
- **Requirements**:
  - Provide domain name only (no subdomain)
  - Configure DNS A record pointing to web-01 IP
  - Domain: `myschool.tech`

### 3. Redirection

- **File**: `3-redirection`
- **Description**: Bash script that configures nginx redirection
- **Requirements**:
  - Configure `/redirect_me` to redirect with "301 Moved Permanently"
  - Redirects to YouTube video
  - Uses sed for line replacement

### 4. Not found page 404

- **File**: `4-not_found_page_404`
- **Description**: Bash script that configures custom 404 page
- **Requirements**:
  - Custom 404 page with "Ceci n'est pas une page"
  - Returns HTTP 404 error code
  - Configures nginx error page handling

## Requirements

- All files interpreted on Ubuntu 16.04 LTS
- All Bash scripts must be executable
- Scripts must pass Shellcheck (version 0.3.7)
- First line: `#!/usr/bin/env bash`
- Second line: comment explaining script purpose
- No systemctl for process restarting
- All files end with new line

## Usage

Each script can be run on a fresh Ubuntu machine to configure it according to the requirements. The scripts are designed to be run as root user and will automatically configure the system without human intervention.
