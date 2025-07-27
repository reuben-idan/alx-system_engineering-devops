@echo off
echo === SSH ACCESS RESOLUTION ===
echo.

echo Step 1: Checking SSH keys...
dir C:\Users\reube\.ssh\

echo.
echo Step 2: Starting SSH agent service...
net start ssh-agent

echo.
echo Step 3: Adding SSH keys...
ssh-add C:\Users\reube\.ssh\id_rsa
ssh-add C:\Users\reube\.ssh\id_ed25519
ssh-add C:\Users\reube\.ssh\*

echo.
echo Step 4: Testing SSH connection...
ssh -o ConnectTimeout=10 ubuntu@54.161.202.254 "echo 'SSH connection successful!'"

echo.
echo If connection fails, try these alternatives:
echo 1. ssh -i C:\Users\reube\.ssh\id_rsa ubuntu@54.161.202.254
echo 2. ssh -i C:\Users\reube\.ssh\id_ed25519 ubuntu@54.161.202.254
echo 3. Use Git Bash instead of PowerShell

pause
