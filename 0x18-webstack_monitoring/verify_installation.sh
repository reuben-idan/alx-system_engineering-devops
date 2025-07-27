#!/bin/bash
# Datadog Agent Verification Script
# Run this on web-01 to verify the installation

echo "=== Datadog Agent Verification ==="
echo ""

# Check hostname
echo "1. Current hostname:"
hostname
echo ""

# Check if datadog-agent service exists and is running
echo "2. Datadog Agent service status:"
sudo systemctl status datadog-agent --no-pager
echo ""

# Check agent detailed status
echo "3. Datadog Agent detailed status:"
sudo datadog-agent status
echo ""

# Check configuration file for hostname
echo "4. Hostname in Datadog configuration:"
grep -n "hostname" /etc/datadog-agent/datadog.yaml || echo "No hostname configured"
echo ""

# Check connectivity
echo "5. Testing connectivity to Datadog:"
sudo datadog-agent check connectivity-datadog-core
echo ""

# Check recent logs
echo "6. Recent agent logs (last 10 lines):"
sudo tail -10 /var/log/datadog/agent.log
echo ""

# Check for errors in logs
echo "7. Checking for errors in logs:"
sudo grep -i error /var/log/datadog/agent.log | tail -5
echo ""

echo "=== Verification Complete ==="
echo ""
echo "Expected results:"
echo "- Hostname should be: XX-web-01"
echo "- Service should be: active (running)"
echo "- Agent should show: Running"
echo "- Connectivity should be: OK"
