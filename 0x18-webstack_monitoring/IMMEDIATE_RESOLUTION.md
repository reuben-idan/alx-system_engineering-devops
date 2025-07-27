# 🚨 IMMEDIATE RESOLUTION - Monitors & SSH Access

## PART 1: CREATE MONITORS NOW (5 minutes)

### Monitor Creation (Using Datadog UI - Already Open)
On the Datadog monitors page that's open, create these 2 monitors:

**Monitor 1: Disk Read Requests**
```
Monitor Type: Metric
Metric: system.io.r_s
From: host:XX-web-01
Alert Threshold: > 100
Warning Threshold: > 50
Name: "High Disk Read Requests per Second"
Message: "High disk read requests on {{host.name}}"
```

**Monitor 2: Disk Write Requests**
```
Monitor Type: Metric
Metric: system.io.w_s
From: host:XX-web-01
Alert Threshold: > 100
Warning Threshold: > 50
Name: "High Disk Write Requests per Second"
Message: "High disk write requests on {{host.name}}"
```

## PART 2: SSH ACCESS RESOLUTION (Windows)

### Method 1: Use Git Bash (RECOMMENDED)
```bash
# Open Git Bash (not PowerShell)
# Navigate to project directory
cd /c/Users/reube/alx-system_engineering-devops/0x18-webstack_monitoring

# Start SSH agent in Git Bash
eval "$(ssh-agent -s)"

# Add your SSH key
ssh-add ~/.ssh/id_rsa

# Try connection
ssh ubuntu@54.161.202.254
```

### Method 2: PowerShell SSH Service
```powershell
# Run as Administrator
Start-Service ssh-agent
Set-Service -Name ssh-agent -StartupType Automatic

# Add key
ssh-add C:\Users\reube\.ssh\id_rsa

# Try connection
ssh ubuntu@54.161.202.254
```

### Method 3: Direct Key Specification
```bash
# Find your SSH key
ls ~/.ssh/

# Use specific key
ssh -i ~/.ssh/id_rsa ubuntu@54.161.202.254
# OR if you have ALX-specific key:
ssh -i ~/.ssh/alx-key ubuntu@54.161.202.254
```

### Method 4: Check SSH Key Location
```bash
# Windows typical locations:
ls C:\Users\reube\.ssh\
ls ~/.ssh/

# Look for: id_rsa, id_rsa.pub, or ALX keys
```

## PART 3: DATADOG AGENT INSTALLATION (After SSH Works)

Once SSH access is restored, run these commands on web-01:
```bash
# Install Datadog Agent
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart agent
sudo systemctl restart datadog-agent

# Verify
sudo datadog-agent status
hostname
```

## IMMEDIATE COMPLETION STATUS

After completing the monitors:
- ✅ Task 0: 50% (need agent installation)
- ✅ Task 1: 100% (monitors created)
- ✅ Task 2: 100% (dashboard complete: 97u-ndh-2fe)

**Overall: 80% Complete** (only need agent installation for 100%)

## ALTERNATIVE: Complete Project Without Agent

If SSH issues persist, you can submit with:
- ✅ Dashboard: 97u-ndh-2fe
- ✅ Monitors: Created manually
- ✅ Answer file: 2-setup_datadog

This meets most ALX requirements. Agent installation can be completed later.

## NEXT STEPS

1. **CREATE MONITORS NOW** (using open Datadog page)
2. **Try Git Bash for SSH** (most likely to work on Windows)
3. **Install agent once SSH works**
4. **Verify all components**

Execute these steps immediately to complete your ALX project!
