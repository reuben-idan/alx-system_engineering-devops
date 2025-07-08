#!/usr/bin/env bash
# Configure UFW to allow only 22, 80, 443 on lb-01
set -e

echo "Resetting UFW to default settings..."
sudo ufw --force reset

echo "Setting default policy to deny incoming..."
sudo ufw default deny incoming

echo "Allowing SSH (22/tcp)..."
sudo ufw allow 22/tcp

echo "Allowing HTTP (80/tcp)..."
sudo ufw allow 80/tcp

echo "Allowing HTTPS (443/tcp)..."
sudo ufw allow 443/tcp

echo "Enabling UFW..."
sudo ufw --force enable

echo "UFW status:"
sudo ufw status verbose 