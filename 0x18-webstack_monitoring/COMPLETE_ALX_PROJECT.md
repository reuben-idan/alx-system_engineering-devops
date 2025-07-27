# ALX 0x18-webstack_monitoring - COMPLETE PROJECT RESOLUTION

## Current Status
✅ All setup files and scripts created
✅ Project structure complete
⚠️ API authentication preventing automation
⚠️ Need to complete manual setup steps

## IMMEDIATE ACTION PLAN

### Step 1: Install Datadog Agent (CRITICAL)
```bash
# SSH to web-01
ssh ubuntu@54.161.202.254

# Install agent
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart
sudo systemctl restart datadog-agent

# Verify
sudo datadog-agent status
hostname
```

### Step 2: Manual Datadog Setup (5 minutes)

#### A. Create Monitors
1. Go to: https://app.datadoghq.com/monitors/create
2. **Monitor 1**:
   - Type: Metric
   - Metric: `system.io.r_s`
   - From: `host:XX-web-01`
   - Alert: `> 100`
   - Name: "High Disk Read Requests per Second"

3. **Monitor 2**:
   - Type: Metric
   - Metric: `system.io.w_s`
   - From: `host:XX-web-01`
   - Alert: `> 100`
   - Name: "High Disk Write Requests per Second"

#### B. Create Dashboard
1. Go to: https://app.datadoghq.com/dashboard/lists
2. Click "New Dashboard"
3. Name: "ALX System Monitoring Dashboard"
4. Add 4+ widgets:
   - CPU Usage: `system.cpu.user{host:XX-web-01}`
   - Memory: `system.mem.used{host:XX-web-01}`
   - Disk Read: `system.io.r_s{host:XX-web-01}`
   - Disk Write: `system.io.w_s{host:XX-web-01}`

#### C. Get Dashboard ID
1. After creating dashboard, copy ID from URL
2. URL format: `https://app.datadoghq.com/dashboard/YOUR-DASHBOARD-ID`
3. Replace content in `2-setup_datadog` with this ID

### Step 3: Update Answer File
Replace the content in `2-setup_datadog` with your actual dashboard ID.

## VERIFICATION CHECKLIST
- [ ] Agent installed on web-01
- [ ] Hostname shows as XX-web-01
- [ ] Server visible in Datadog Infrastructure
- [ ] 2 monitors created for disk I/O
- [ ] Dashboard created with 4+ widgets
- [ ] Dashboard ID saved in `2-setup_datadog`

## ALTERNATIVE: Quick Dashboard ID
If you create the dashboard manually, here's how to get the ID:

1. Create dashboard in Datadog UI
2. Look at browser URL: `https://app.datadoghq.com/dashboard/abc-123-def`
3. Copy the ID part: `abc-123-def`
4. Update the file:

```bash
echo "your-actual-dashboard-id" > 2-setup_datadog
```

## PROJECT COMPLETION
Once you complete the manual steps above, your ALX project will be 100% complete with all requirements met:

✅ Task 0: Datadog agent installed
✅ Task 1: Monitors for read/write requests
✅ Task 2: Dashboard with 4+ widgets and ID saved

The only file needed for submission is `2-setup_datadog` with the dashboard ID.
