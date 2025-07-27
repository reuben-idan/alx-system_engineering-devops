# Datadog Monitors and Dashboard Setup Guide

## Prerequisites
- Datadog Agent must be installed and running on web-01
- You need your Datadog API key and Application key

## Task 1: Set up Monitors for Disk I/O

### Monitor 1: Disk Read Requests per Second
1. Go to Datadog Dashboard → Monitors → New Monitor
2. Select "Metric" monitor type
3. Configure the monitor:
   - **Metric**: `system.io.r_s` (read requests per second)
   - **From**: Select your host (XX-web-01)
   - **Alert Threshold**: Set appropriate threshold (e.g., > 100 reads/sec)
   - **Warning Threshold**: Set warning level (e.g., > 50 reads/sec)
   - **Monitor Name**: "High Disk Read Requests per Second"
   - **Message**: "Disk read requests are high on {{host.name}}"

### Monitor 2: Disk Write Requests per Second
1. Go to Datadog Dashboard → Monitors → New Monitor
2. Select "Metric" monitor type
3. Configure the monitor:
   - **Metric**: `system.io.w_s` (write requests per second)
   - **From**: Select your host (XX-web-01)
   - **Alert Threshold**: Set appropriate threshold (e.g., > 100 writes/sec)
   - **Warning Threshold**: Set warning level (e.g., > 50 writes/sec)
   - **Monitor Name**: "High Disk Write Requests per Second"
   - **Message**: "Disk write requests are high on {{host.name}}"

## Task 2: Create Dashboard

### Step 1: Create New Dashboard
1. Go to Datadog → Dashboards → New Dashboard
2. Choose "New Dashboard"
3. Name it: "ALX System Monitoring Dashboard"

### Step 2: Add 4+ Widgets
Add at least these 4 widgets:

1. **CPU Usage Widget**
   - Widget Type: Timeseries
   - Metric: `system.cpu.user`
   - Title: "CPU Usage"

2. **Memory Usage Widget**
   - Widget Type: Timeseries
   - Metric: `system.mem.used`
   - Title: "Memory Usage"

3. **Disk Read I/O Widget**
   - Widget Type: Timeseries
   - Metric: `system.io.r_s`
   - Title: "Disk Read Requests/sec"

4. **Disk Write I/O Widget**
   - Widget Type: Timeseries
   - Metric: `system.io.w_s`
   - Title: "Disk Write Requests/sec"

### Step 3: Get Dashboard ID
1. After creating the dashboard, look at the URL
2. The dashboard ID is in the URL: `https://app.datadoghq.com/dashboard/abc-def-ghi`
3. The ID is the part after `/dashboard/` (e.g., `abc-def-ghi`)

### Step 4: Save Dashboard ID
Create the file `2-setup_datadog` with the dashboard ID on the first line.

## Alternative: Using Datadog API
If you need to get the dashboard ID programmatically:

```bash
curl -X GET "https://api.datadoghq.com/api/v1/dashboard" \
     -H "Content-Type: application/json" \
     -H "DD-API-KEY: YOUR_API_KEY" \
     -H "DD-APPLICATION-KEY: YOUR_APP_KEY"
```

## Verification
- Check that both monitors are created and active
- Verify dashboard displays all 4+ widgets
- Confirm dashboard ID is saved in `2-setup_datadog` file
