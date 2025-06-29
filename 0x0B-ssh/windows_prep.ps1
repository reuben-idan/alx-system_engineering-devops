# SSH Project Windows Preparation Script
# This script prepares files for transfer to Ubuntu

Write-Host "🚀 SSH Project Windows Preparation" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# Check if we're in the right directory
if (-not (Test-Path "0x0B-ssh")) {
    Write-Host "❌ Please run this script from the project root directory" -ForegroundColor Red
    exit 1
}

# Change to SSH directory
Set-Location "0x0B-ssh"

Write-Host "📁 Current directory: $(Get-Location)" -ForegroundColor Yellow

# List all project files
Write-Host "`n📋 Project files:" -ForegroundColor Cyan
Get-ChildItem -Name | ForEach-Object { Write-Host "  - $_" -ForegroundColor White }

Write-Host "`n✅ Files are ready for Ubuntu setup!" -ForegroundColor Green
Write-Host "`n📋 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Copy the 0x0B-ssh directory to your Ubuntu server or WSL" -ForegroundColor White
Write-Host "2. On Ubuntu, run: chmod +x ubuntu_setup.sh && ./ubuntu_setup.sh" -ForegroundColor White
Write-Host "3. Get your server IP from ALX intranet 'My Servers' section" -ForegroundColor White
Write-Host "4. Edit 0-use_a_private_key and replace <IP_ADDRESS> with your server IP" -ForegroundColor White
Write-Host "5. Follow the setup guide in SETUP_GUIDE.md" -ForegroundColor White

Write-Host "`n🔗 Quick Ubuntu Commands:" -ForegroundColor Cyan
Write-Host "cd 0x0B-ssh" -ForegroundColor Gray
Write-Host "chmod +x ubuntu_setup.sh" -ForegroundColor Gray
Write-Host "./ubuntu_setup.sh" -ForegroundColor Gray
Write-Host "ssh-copy-id -i school.pub ubuntu@<YOUR_SERVER_IP>" -ForegroundColor Gray
Write-Host "./0-use_a_private_key" -ForegroundColor Gray 