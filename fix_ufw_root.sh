#!/usr/bin/env bash
# Configure UFW to allow only 22, 80, 443 on web-01 (run as root, no sudo)
set -e

echo "Resetting UFW to default settings..."
ufw --force reset

echo "Setting default policy to deny incoming..."
ufw default deny incoming

echo "Allowing SSH (22/tcp)..."
ufw allow 22/tcp

echo "Allowing HTTP (80/tcp)..."
ufw allow 80/tcp

echo "Allowing HTTPS (443/tcp)..."
ufw allow 443/tcp

echo "Enabling UFW..."
ufw --force enable

echo "UFW status:"
ufw status verbose 