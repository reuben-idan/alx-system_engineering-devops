# ALX Web Terminal Access - Step-by-Step Guide

## 🎯 GOAL: Access web-01 server to install Datadog agent

## STEP 1: Access ALX Intranet

### Method A: Direct Login
1. **Go to**: https://intranet.alxswe.com/
2. **Login** with your ALX credentials
3. **Navigate** to your dashboard

### Method B: ALX Main Site
1. **Go to**: https://www.alxafrica.com/
2. **Click "Student Login"** or "Intranet"
3. **Enter** your ALX credentials

## STEP 2: Find Your Project

### Option 1: From Dashboard
1. **Look for "Projects"** section
2. **Find**: "0x18-webstack_monitoring"
3. **Click** on the project

### Option 2: From Curriculum
1. **Navigate** to "Curriculum" or "SE Foundations"
2. **Find**: System Engineering & DevOps track
3. **Locate**: 0x18-webstack_monitoring
4. **Click** on the project

## STEP 3: Access Web Terminal

### Look for these options:
- **"Webterm"** button
- **"Terminal"** link
- **"SSH"** option
- **"Connect to server"** button
- **"web-01"** server link

### Common locations:
- **Top right** of project page
- **Server information** section
- **Resources** tab
- **Tools** menu

## STEP 4: Alternative Access Methods

### Method A: Server List
1. **Look for "Your servers"** section
2. **Find**: web-01 (54.161.202.254)
3. **Click**: "Connect" or "Terminal"

### Method B: Sandbox
1. **Look for "Sandbox"** option
2. **Select**: Ubuntu 20.04
3. **Connect** to sandbox environment

### Method C: Container Access
1. **Check for "Container"** options
2. **Look for "Start container"**
3. **Access** web-01 through container

## STEP 5: Once You Have Terminal Access

**Copy-paste these commands exactly:**

```bash
# Verify you're on the right server
hostname
whoami

# Install Datadog Agent
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update Datadog config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart agent
sudo systemctl restart datadog-agent

# Verify installation
sudo datadog-agent status
hostname

# Success message
echo "✅ Datadog agent installed successfully!"
echo "Check https://app.datadoghq.com/infrastructure for XX-web-01"
```

## 🔍 TROUBLESHOOTING

### If you can't find web terminal:
1. **Check project requirements** - look for server access instructions
2. **Look in "Resources"** tab of your project
3. **Check "Getting Started"** section
4. **Look for "Checker"** - sometimes terminal access is there

### If web terminal doesn't work:
1. **Try different browser** (Chrome, Firefox)
2. **Disable ad blockers**
3. **Clear browser cache**
4. **Try incognito/private mode**

### If you see "No servers available":
1. **Check project status** - ensure it's started
2. **Look for "Start project"** button
3. **Verify your ALX account** is active
4. **Contact ALX support** if servers aren't provisioned

## 📞 ALX SUPPORT OPTIONS

### If you still can't access:
1. **ALX Help Desk**: Through intranet messaging
2. **Slack**: #help or #technical-issues channel
3. **Email**: support@alxafrica.com
4. **Peer Help**: Ask classmates in Slack

## 🎉 SUCCESS INDICATORS

You'll know it worked when:
- ✅ **Terminal opens** with ubuntu@web-01 prompt
- ✅ **Commands execute** without errors
- ✅ **Agent status** shows "Agent (v7.x.x)"
- ✅ **Hostname** shows "XX-web-01"
- ✅ **Server appears** in Datadog Infrastructure list

## NEXT STEPS AFTER SUCCESS

1. **Verify** server appears in Datadog: https://app.datadoghq.com/infrastructure
2. **Check** that XX-web-01 is listed
3. **Confirm** monitors are working
4. **Project 100% complete!** 🎉

## VISUAL CLUES TO LOOK FOR

- **Terminal icon** 🖥️
- **"Connect"** buttons
- **Server IP**: 54.161.202.254
- **"web-01"** server name
- **"Ubuntu"** or "SSH" labels

Take your time exploring the ALX interface - the web terminal access is definitely there!
