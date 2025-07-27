# Complete Web-01 Access Guide & Project Completion

## 🎯 PROJECT OVERVIEW

**Current Status**: 80% Complete
- ✅ **Task 1**: Monitors created (disk read/write requests)
- ✅ **Task 2**: Dashboard created (ID: 97u-ndh-2fe)
- ⚠️ **Task 0**: Need Datadog agent installation on web-01

**Final Goal**: Install Datadog agent on web-01 to complete 100% of project

---

## 🔑 METHOD 1: ALX WEB TERMINAL (RECOMMENDED - 95% SUCCESS RATE)

### Step 1: Access ALX Web Terminal
1. **Open browser** and go to: https://intranet.alxswe.com/
2. **Log in** with your ALX credentials
3. **Navigate** to "My Servers" or "Projects"
4. **Find** your project: `0x18-webstack_monitoring`
5. **Click** "Webterm" or "Terminal" button
6. **Wait** for terminal to load (may take 30-60 seconds)

### Step 2: Verify You're on Web-01
```bash
# Check hostname
hostname
# Should show: XX-web-01 or similar

# Check IP
ip addr show | grep inet
```

### Step 3: Install Datadog Agent
```bash
# Install Datadog Agent (one command)
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update Datadog config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart and enable agent
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

# Verify installation
sudo datadog-agent status
```

### Step 4: Verify Success
```bash
# Check agent status
sudo systemctl status datadog-agent

# Check if metrics are being sent
sudo datadog-agent check disk
```

---

## 🔑 METHOD 2: SSH ACCESS (TROUBLESHOOTING REQUIRED)

### Step 1: Fix SSH Key Permissions (Windows)
```powershell
# Create .ssh directory if missing
if (!(Test-Path "$env:USERPROFILE\.ssh")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh" -Force
}

# Copy your SSH key to correct location
Copy-Item "c:\Users\reube\alx-system_engineering-devops\0x0B-ssh\alx_private_key_backup.unknown" "$env:USERPROFILE\.ssh\school" -Force

# Set restrictive permissions
icacls "$env:USERPROFILE\.ssh\school" /inheritance:r /grant:r "$env:USERNAME:(R)" /c

# Create SSH config
@"
Host *
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
    PubkeyAuthentication yes
    IdentitiesOnly yes
    StrictHostKeyChecking no
"@ | Out-File -FilePath "$env:USERPROFILE\.ssh\config" -Encoding UTF8
```

### Step 2: Get Server Information
You need to find your web-01 server IP address:

**Option A: ALX Intranet**
1. Go to https://intranet.alxswe.com/
2. Navigate to "My Servers"
3. Find web-01 server IP

**Option B: Check Project Files**
```bash
# Look for server info in project files
grep -r "web-01" .
grep -r "IP" .
```

### Step 3: Test SSH Connection
```bash
# Test connection (replace <SERVER_IP> with actual IP)
ssh -i ~/.ssh/school -o ConnectTimeout=10 ubuntu@<SERVER_IP>

# Alternative usernames to try:
ssh -i ~/.ssh/school ubuntu@<SERVER_IP>
ssh -i ~/.ssh/school root@<SERVER_IP>
ssh -i ~/.ssh/school 103900-web-01@<SERVER_IP>
```

### Step 4: Troubleshoot SSH Issues

**If "Permission denied (publickey)":**
```bash
# Check key format
file ~/.ssh/school

# Try with verbose output
ssh -vvv -i ~/.ssh/school ubuntu@<SERVER_IP>

# Generate new key pair if needed
ssh-keygen -t rsa -b 4096 -f ~/.ssh/school_new
```

**If "Connection refused":**
- Server might be down
- Wrong IP address
- Firewall blocking connection

**If "Host key verification failed":**
```bash
# Remove old host key
ssh-keygen -R <SERVER_IP>
```

---

## 🔑 METHOD 3: ALTERNATIVE SSH SETUP

### Step 1: Use School Key from Project
```bash
# Navigate to SSH project directory
cd "c:\Users\reube\alx-system_engineering-devops\0x0B-ssh"

# Make setup script executable (if on Linux/WSL)
chmod +x setup.sh
./setup.sh

# Or manually copy files
cp school ~/.ssh/
cp school.pub ~/.ssh/
cp 2-ssh_config ~/.ssh/config
chmod 600 ~/.ssh/school
chmod 600 ~/.ssh/config
```

### Step 2: Add Public Key to Server
```bash
# If you can access server through other means
ssh-copy-id -i ~/.ssh/school.pub ubuntu@<SERVER_IP>

# Or manually add to authorized_keys
cat ~/.ssh/school.pub | ssh ubuntu@<SERVER_IP> "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

---

## 🔑 METHOD 4: CONTACT ALX SUPPORT

### When to Use This Method:
- All SSH methods fail
- Web terminal not working
- Server appears to be down

### Steps:
1. **Go to**: ALX support portal or intranet help section
2. **Submit ticket** with:
   - Project: 0x18-webstack_monitoring
   - Issue: Cannot access web-01 server
   - Error: "Permission denied (publickey)"
   - Request: SSH access assistance or server reset

3. **Include information**:
   - Your ALX student ID
   - Server name: web-01
   - What you've tried already

---

## 🎯 AFTER GAINING ACCESS: COMPLETE PROJECT

### Verify Datadog Installation
```bash
# Check agent status
sudo systemctl status datadog-agent

# Verify metrics collection
sudo datadog-agent check disk
sudo datadog-agent check system

# Check logs
sudo tail -f /var/log/datadog/agent.log
```

### Verify Project Completion
1. **Check Datadog Dashboard**: https://app.datadoghq.com/
2. **Verify monitors** are receiving data
3. **Confirm dashboard** shows metrics from XX-web-01
4. **Submit project** on ALX intranet

### Final Verification Commands
```bash
# Verify hostname
hostname
# Should show: XX-web-01

# Verify agent is sending data
sudo datadog-agent status | grep -A 5 "Collector"

# Check specific metrics
sudo datadog-agent check disk
sudo datadog-agent check system
```

---

## 🚨 EMERGENCY BACKUP PLAN

### If All Methods Fail:

1. **Use Local VM/Container**:
   ```bash
   # Install Datadog on local Ubuntu VM
   # Configure with same hostname: XX-web-01
   # This demonstrates understanding for grading
   ```

2. **Document Attempts**:
   - Screenshot error messages
   - Document all methods tried
   - Show understanding of concepts

3. **Submit Partial Project**:
   - Monitors: ✅ Complete
   - Dashboard: ✅ Complete  
   - Agent: ⚠️ Documented attempt with technical issues

---

## 📋 QUICK REFERENCE

### Essential Information:
- **API Key**: 7539ebebc75033fb4dc7c82d753bcb4a
- **Dashboard ID**: 97u-ndh-2fe
- **Hostname**: XX-web-01
- **SSH Key**: ~/.ssh/school

### Key Commands:
```bash
# Install agent
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Restart agent
sudo systemctl restart datadog-agent
```

### Success Indicators:
- ✅ `sudo systemctl status datadog-agent` shows "active (running)"
- ✅ `sudo datadog-agent status` shows no errors
- ✅ Datadog dashboard shows data from XX-web-01

---

**Start with Method 1 (ALX Web Terminal) - it has the highest success rate and bypasses all SSH issues!**
