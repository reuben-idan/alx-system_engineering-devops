# ALX 0x18-webstack_monitoring - Final Setup Instructions

## API Authentication Issue Resolution

The automated script encountered a 403 authentication error. This is likely due to:
1. API key permissions
2. Application key permissions
3. Account region mismatch

## Manual Completion Steps

### Step 1: Verify Datadog Agent Installation
```bash
# SSH to web-01
ssh ubuntu@54.161.202.254

# Check if agent is installed
sudo datadog-agent status

# If not installed, run:
DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname XX-web-01

# Update config
sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml

# Restart agent
sudo systemctl restart datadog-agent
```

### Step 2: Create Monitors (Manual)
Go to https://app.datadoghq.com/monitors/create

**Monitor 1: Disk Read Requests**
- Monitor Type: Metric
- Define the metric: `system.io.r_s`
- From: `host:XX-web-01`
- Alert threshold: `> 100`
- Warning threshold: `> 50`
- Monitor name: "High Disk Read Requests per Second"
- Message: "Disk read requests are high on {{host.name}}"

**Monitor 2: Disk Write Requests**
- Monitor Type: Metric
- Define the metric: `system.io.w_s`
- From: `host:XX-web-01`
- Alert threshold: `> 100`
- Warning threshold: `> 50`
- Monitor name: "High Disk Write Requests per Second"
- Message: "Disk write requests are high on {{host.name}}"

### Step 3: Create Dashboard (Manual)
Go to https://app.datadoghq.com/dashboard/lists

1. Click "New Dashboard"
2. Choose "New Dashboard"
3. Name: "ALX System Monitoring Dashboard"
4. Add these widgets:

**Widget 1: CPU Usage**
- Widget type: Timeseries
- Metric: `system.cpu.user`
- From: `host:XX-web-01`
- Title: "CPU Usage"

**Widget 2: Memory Usage**
- Widget type: Timeseries
- Metric: `system.mem.used`
- From: `host:XX-web-01`
- Title: "Memory Usage"

**Widget 3: Disk Read I/O**
- Widget type: Timeseries
- Metric: `system.io.r_s`
- From: `host:XX-web-01`
- Title: "Disk Read Requests/sec"

**Widget 4: Disk Write I/O**
- Widget type: Timeseries
- Metric: `system.io.w_s`
- From: `host:XX-web-01`
- Title: "Disk Write Requests/sec"

**Widget 5: System Load**
- Widget type: Timeseries
- Metric: `system.load.1`
- From: `host:XX-web-01`
- Title: "System Load Average"

### Step 4: Get Dashboard ID
1. After creating the dashboard, look at the URL
2. URL format: `https://app.datadoghq.com/dashboard/abc-def-ghi`
3. Copy the ID part after `/dashboard/`
4. Replace the content in `2-setup_datadog` with this ID

### Step 5: Verify Completion
- [ ] Agent installed and running on XX-web-01
- [ ] Server visible in Datadog Infrastructure list
- [ ] Two monitors created for disk I/O
- [ ] Dashboard created with 5 widgets
- [ ] Dashboard ID saved in `2-setup_datadog` file

## Troubleshooting API Issues

If you want to try the API approach again:
1. Verify your Application Key has the correct permissions
2. Check that you're using the US site (.com)
3. Ensure the API key and Application key are from the same account
4. Try regenerating the Application Key if needed

## Final Deliverable
The only file required for ALX submission is:
- `2-setup_datadog` (containing only the dashboard ID)

Current content: `abc-def-ghi` (replace with your actual dashboard ID)
