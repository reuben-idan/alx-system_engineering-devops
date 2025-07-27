# 🚨 EXECUTE NOW - Complete ALX Agent Installation

## IMMEDIATE ACTIONS REQUIRED

### Step 1: SSH to web-01 (Manual)
Open a new terminal/command prompt and run:
```bash
ssh ubuntu@54.161.202.254
```
- When prompted about host authenticity, type: `yes`
- Enter your SSH key passphrase if prompted

### Step 2: Install Datadog Agent (Copy-Paste Commands)
Once connected to web-01, run these commands one by one:

```bash
# Install Datadog Agent
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update Datadog config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart agent
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

# Verify installation
sudo datadog-agent status
hostname
```

### Step 3: Verify Server Appears in Datadog
1. Go to: https://app.datadoghq.com/infrastructure
2. Wait 5-10 minutes for XX-web-01 to appear
3. Confirm the server is listed

### Step 4: Create Required Monitors
Go to: https://app.datadoghq.com/monitors/create

**Monitor 1: Disk Read Requests**
- Monitor Type: Metric
- Define the metric: `system.io.r_s`
- From: `host:XX-web-01`
- Alert threshold: `> 100`
- Warning threshold: `> 50`
- Monitor name: "High Disk Read Requests per Second"

**Monitor 2: Disk Write Requests**
- Monitor Type: Metric
- Define the metric: `system.io.w_s`
- From: `host:XX-web-01`
- Alert threshold: `> 100`
- Warning threshold: `> 50`
- Monitor name: "High Disk Write Requests per Second"

## VERIFICATION CHECKLIST
After completing the above:
- [ ] Agent installed on web-01
- [ ] Hostname shows as XX-web-01
- [ ] Server visible in Datadog Infrastructure
- [ ] 2 monitors created for disk I/O
- [ ] Dashboard working (already complete: 97u-ndh-2fe)

## COMPLETION STATUS
Once you complete these steps:
- **Task 0**: 100% ✅ (Agent installed, server visible)
- **Task 1**: 100% ✅ (Monitors created)
- **Task 2**: 100% ✅ (Dashboard already complete)

**Overall ALX Project**: 100% COMPLETE ✅

## ALTERNATIVE: Use Installation Script
If you prefer, copy the `install_agent_web01.sh` script to web-01 and run:
```bash
chmod +x install_agent_web01.sh
./install_agent_web01.sh
```

## URGENT: Execute Now
Your ALX project is 40% complete. These steps will bring it to 100% completion and full ALX compliance.
