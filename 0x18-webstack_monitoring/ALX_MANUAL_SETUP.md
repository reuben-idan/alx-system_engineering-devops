# ALX 0x18-webstack_monitoring Manual Setup Guide

## Task 0: Install Datadog Agent ✅
**Status**: Setup files created

### Steps to complete:
1. SSH to web-01: `ssh ubuntu@54.161.202.254`
2. Run: `bash complete_datadog_setup.sh`
3. Verify hostname shows as `XX-web-01`

## Task 1: Monitor Metrics ✅
**Requirement**: Set up monitors for disk read/write requests per second

### Manual Setup:
1. Go to https://app.datadoghq.com/monitors/create
2. **Monitor 1 - Disk Read Requests**:
   - Type: Metric
   - Metric: `system.io.r_s`
   - Host: `XX-web-01`
   - Alert threshold: `> 100`
   - Warning threshold: `> 50`
   - Name: "High Disk Read Requests per Second"

3. **Monitor 2 - Disk Write Requests**:
   - Type: Metric
   - Metric: `system.io.w_s`
   - Host: `XX-web-01`
   - Alert threshold: `> 100`
   - Warning threshold: `> 50`
   - Name: "High Disk Write Requests per Second"

## Task 2: Create Dashboard ⚠️
**Requirement**: Create dashboard with 4+ widgets and save ID to `2-setup_datadog`

### Manual Setup:
1. Go to https://app.datadoghq.com/dashboard/lists
2. Click "New Dashboard"
3. Name: "ALX System Monitoring Dashboard"
4. Add these widgets:
   - **Widget 1**: CPU Usage (`system.cpu.user` for `XX-web-01`)
   - **Widget 2**: Memory Usage (`system.mem.used` for `XX-web-01`)
   - **Widget 3**: Disk Read I/O (`system.io.r_s` for `XX-web-01`)
   - **Widget 4**: Disk Write I/O (`system.io.w_s` for `XX-web-01`)
   - **Widget 5**: System Load (`system.load.1` for `XX-web-01`)

5. **Get Dashboard ID**:
   - After creating, look at URL: `https://app.datadoghq.com/dashboard/abc-def-ghi`
   - Copy the ID part: `abc-def-ghi`
   - Replace content in `2-setup_datadog` file with this ID

## Verification Checklist
- [ ] Datadog agent installed on web-01
- [ ] Server visible as `XX-web-01` in Datadog
- [ ] Two monitors created for disk I/O
- [ ] Dashboard created with 5+ widgets
- [ ] Dashboard ID saved in `2-setup_datadog` file
- [ ] All files committed to git repository

## Files Required for Submission
- `2-setup_datadog` (contains dashboard ID only)

## Quick Commands
```bash
# SSH to web-01
ssh ubuntu@54.161.202.254

# Run complete setup
bash complete_datadog_setup.sh

# Check agent status
sudo datadog-agent status

# Verify hostname
hostname
```

## Important Notes
- Use US Datadog site (.com, not .eu)
- Hostname must be exactly `XX-web-01`
- Dashboard ID goes on first line of `2-setup_datadog`
- No additional content in the answer file
