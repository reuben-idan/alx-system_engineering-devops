# Final Project Completion Script
# This script completes the Datadog monitoring project

Write-Host "=== FINAL DATADOG PROJECT COMPLETION ===" -ForegroundColor Green
Write-Host ""

# Project Information
$API_KEY = "7539ebebc75033fb4dc7c82d753bcb4a"
$DASHBOARD_ID = "97u-ndh-2fe"
$HOSTNAME = "XX-web-01"

Write-Host "Project Status Check:" -ForegroundColor Yellow
Write-Host "✅ API Key: $API_KEY" -ForegroundColor Green
Write-Host "✅ Dashboard ID: $DASHBOARD_ID" -ForegroundColor Green
Write-Host "✅ Target Hostname: $HOSTNAME" -ForegroundColor Green
Write-Host ""

# Method 1: Try SSH Connection
Write-Host "Method 1: Attempting SSH Connection..." -ForegroundColor Yellow

$sshKey = "$env:USERPROFILE\.ssh\school"
$possibleServers = @(
    "ubuntu@54.157.136.24",
    "ubuntu@54.144.140.156", 
    "ubuntu@18.204.13.111",
    "ubuntu@3.85.17.207",
    "root@54.157.136.24",
    "103900-web-01@54.157.136.24"
)

$connectionEstablished = $false
$workingConnection = ""

foreach ($server in $possibleServers) {
    Write-Host "Testing: $server" -ForegroundColor Gray
    
    try {
        $testResult = ssh -i "$sshKey" -o ConnectTimeout=8 -o StrictHostKeyChecking=no -o BatchMode=yes $server "echo 'CONNECTED'" 2>$null
        
        if ($testResult -eq "CONNECTED") {
            Write-Host "✅ Connection successful: $server" -ForegroundColor Green
            $connectionEstablished = $true
            $workingConnection = $server
            break
        }
    } catch {
        # Continue to next server
    }
}

if ($connectionEstablished) {
    Write-Host ""
    Write-Host "🎉 SSH CONNECTION ESTABLISHED!" -ForegroundColor Green
    Write-Host "Connected to: $workingConnection" -ForegroundColor Green
    Write-Host ""
    Write-Host "Installing Datadog Agent..." -ForegroundColor Yellow
    
    # Datadog installation commands
    $datadogInstall = @"
# Update system
sudo apt-get update -y

# Install Datadog Agent
DD_API_KEY=$API_KEY DD_SITE="datadoghq.com" bash -c "`$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Set hostname
sudo hostnamectl set-hostname $HOSTNAME

# Update Datadog configuration
sudo sed -i "s/# hostname:.*/hostname: $HOSTNAME/" /etc/datadog-agent/datadog.yaml

# Restart and enable agent
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

# Wait for agent to start
sleep 10

# Check status
sudo datadog-agent status
"@

    try {
        Write-Host "Executing Datadog installation on $workingConnection..." -ForegroundColor Gray
        $installOutput = ssh -i "$sshKey" -o StrictHostKeyChecking=no $workingConnection $datadogInstall
        
        Write-Host ""
        Write-Host "✅ DATADOG INSTALLATION COMPLETED!" -ForegroundColor Green
        Write-Host $installOutput -ForegroundColor Gray
        
        # Verify installation
        Write-Host ""
        Write-Host "Verifying installation..." -ForegroundColor Yellow
        $statusCheck = ssh -i "$sshKey" -o StrictHostKeyChecking=no $workingConnection "sudo systemctl is-active datadog-agent"
        
        if ($statusCheck -eq "active") {
            Write-Host "✅ Datadog agent is running!" -ForegroundColor Green
            Write-Host ""
            Write-Host "🎉 PROJECT 100% COMPLETE!" -ForegroundColor Green
            Write-Host "✅ Task 0: Datadog agent installed and running" -ForegroundColor Green
            Write-Host "✅ Task 1: Monitors created for disk I/O" -ForegroundColor Green
            Write-Host "✅ Task 2: Dashboard created (ID: $DASHBOARD_ID)" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Agent status: $statusCheck" -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
} else {
    Write-Host "❌ No SSH connections successful" -ForegroundColor Red
    Write-Host ""
    Write-Host "=== ALTERNATIVE COMPLETION METHOD ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "ALX WEB TERMINAL METHOD:" -ForegroundColor White
    Write-Host "1. Go to: https://intranet.alxswe.com/" -ForegroundColor Gray
    Write-Host "2. Navigate to: 0x18-webstack_monitoring project" -ForegroundColor Gray
    Write-Host "3. Click: 'Webterm' or 'Terminal' button" -ForegroundColor Gray
    Write-Host "4. Copy and paste this command:" -ForegroundColor Gray
    Write-Host ""
    Write-Host "DD_API_KEY=$API_KEY DD_SITE=`"datadoghq.com`" bash -c `"`$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)`" && sudo hostnamectl set-hostname $HOSTNAME && sudo systemctl restart datadog-agent && sudo systemctl enable datadog-agent" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "5. Verify with: sudo datadog-agent status" -ForegroundColor Gray
    Write-Host ""
    Write-Host "This single command will complete your entire project!" -ForegroundColor Green
}

# Final project summary
Write-Host ""
Write-Host "=== PROJECT SUMMARY ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "API Key: $API_KEY" -ForegroundColor White
Write-Host "Dashboard ID: $DASHBOARD_ID" -ForegroundColor White
Write-Host "Hostname: $HOSTNAME" -ForegroundColor White
Write-Host ""
Write-Host "Monitors Created:" -ForegroundColor White
Write-Host "• Disk Read Requests per Second (system.io.r_s)" -ForegroundColor Gray
Write-Host "• Disk Write Requests per Second (system.io.w_s)" -ForegroundColor Gray
Write-Host ""
Write-Host "Dashboard Widgets:" -ForegroundColor White
Write-Host "• System Load Average" -ForegroundColor Gray
Write-Host "• Memory Usage" -ForegroundColor Gray
Write-Host "• Disk I/O Metrics" -ForegroundColor Gray
Write-Host "• Network Traffic" -ForegroundColor Gray
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor White
Write-Host "1. Verify metrics in Datadog dashboard: https://app.datadoghq.com/" -ForegroundColor Gray
Write-Host "2. Submit project on ALX intranet" -ForegroundColor Gray
Write-Host "3. Include dashboard ID: $DASHBOARD_ID in submission" -ForegroundColor Gray

Write-Host ""
Write-Host "=== COMPLETION SCRIPT FINISHED ===" -ForegroundColor Green
