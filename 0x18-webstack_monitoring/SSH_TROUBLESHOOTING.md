# SSH Permission Denied (Publickey) - Troubleshooting Guide

## Error: Permission denied (publickey)
This error occurs when SSH cannot authenticate with the server using your private key.

## SOLUTION METHODS

### Method 1: Check SSH Key Location and Permissions
```bash
# Check if SSH keys exist
ls -la ~/.ssh/

# Look for these files:
# - id_rsa (private key)
# - id_rsa.pub (public key)
# - known_hosts

# If keys exist, check permissions
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh/
```

### Method 2: Use SSH with Verbose Output
```bash
# Get detailed SSH connection info
ssh -v ubuntu@54.161.202.254

# This will show:
# - Which keys are being tried
# - Authentication methods
# - Connection details
```

### Method 3: Specify SSH Key Explicitly
```bash
# If you have a specific key file
ssh -i /path/to/your/private/key ubuntu@54.161.202.254

# Common locations:
ssh -i ~/.ssh/id_rsa ubuntu@54.161.202.254
ssh -i ~/.ssh/alx-key ubuntu@54.161.202.254
```

### Method 4: Check SSH Agent
```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add your key to agent
ssh-add ~/.ssh/id_rsa

# List loaded keys
ssh-add -l

# Then try connecting
ssh ubuntu@54.161.202.254
```

### Method 5: Generate New SSH Key (If Needed)
```bash
# Generate new SSH key pair
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Add to SSH agent
ssh-add ~/.ssh/id_rsa

# Copy public key to server (if you have access)
ssh-copy-id ubuntu@54.161.202.254
```

## WINDOWS-SPECIFIC SOLUTIONS

### Using PowerShell/Windows
```powershell
# Check SSH service
Get-Service ssh-agent

# Start SSH agent if needed
Start-Service ssh-agent

# Add key to agent
ssh-add C:\Users\YourUsername\.ssh\id_rsa
```

### Using Git Bash (Recommended for Windows)
```bash
# Open Git Bash instead of PowerShell
# Navigate to your project directory
cd /c/Users/reube/alx-system_engineering-devops/0x18-webstack_monitoring

# Try SSH connection
ssh ubuntu@54.161.202.254
```

## ALX-SPECIFIC SOLUTIONS

### Check ALX SSH Key Setup
```bash
# If you're using ALX-provided keys
ls ~/.ssh/

# Look for ALX-specific key files
# Common names: alx-key, school-key, etc.

# Use specific key
ssh -i ~/.ssh/alx-key ubuntu@54.161.202.254
```

### Alternative: Use ALX Sandbox
If SSH continues to fail, you can:
1. Use ALX web-based terminal/sandbox
2. Access web-01 through ALX platform
3. Run the Datadog installation commands there

## QUICK DIAGNOSTIC COMMANDS

```bash
# 1. Check SSH configuration
cat ~/.ssh/config

# 2. Test SSH connection with verbose output
ssh -vvv ubuntu@54.161.202.254

# 3. Check if key is loaded in agent
ssh-add -l

# 4. Test key permissions
ls -la ~/.ssh/id_rsa
```

## IMMEDIATE WORKAROUND FOR ALX PROJECT

If SSH issues persist, you can complete the ALX project using these alternatives:

### Option A: Use ALX Web Terminal
1. Log into ALX platform
2. Access web-01 through web terminal
3. Run the Datadog installation commands

### Option B: Skip Agent Installation (Temporary)
Since you already have:
- ✅ Dashboard created (97u-ndh-2fe)
- ✅ Answer file correct
- ✅ API keys configured

You can:
1. Create the monitors manually in Datadog UI
2. Submit the project with current setup
3. Install agent later for full functionality

### Option C: Contact ALX Support
If this is an ALX infrastructure issue:
1. Contact ALX technical support
2. Report SSH access issues to web-01
3. Request assistance with server access

## NEXT STEPS

1. **Try Method 4** (SSH Agent) first - most common solution
2. **Use Git Bash** instead of PowerShell if on Windows
3. **Check verbose SSH output** to identify specific issue
4. **Use ALX web terminal** as backup option

Once SSH access is restored, return to the Datadog agent installation process.
