# SSH Permission Denied (publickey) Fix Script for Windows
# This script addresses common SSH authentication issues

Write-Host "=== SSH Permission Denied (publickey) Fix Script ===" -ForegroundColor Green
Write-Host ""

# Step 1: Check if SSH key exists
$sshKeyPath = "$env:USERPROFILE\.ssh\school"
$sshKeyBackupPath = "c:\Users\reube\alx-system_engineering-devops\0x0B-ssh\alx_private_key_backup.unknown"

Write-Host "Step 1: Checking SSH key files..." -ForegroundColor Yellow

if (Test-Path $sshKeyPath) {
    Write-Host "✅ SSH key found at: $sshKeyPath" -ForegroundColor Green
} elseif (Test-Path $sshKeyBackupPath) {
    Write-Host "⚠️  SSH key backup found. Copying to correct location..." -ForegroundColor Yellow
    
    # Create .ssh directory if it doesn't exist
    if (!(Test-Path "$env:USERPROFILE\.ssh")) {
        New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh" -Force
        Write-Host "✅ Created .ssh directory" -ForegroundColor Green
    }
    
    # Copy the backup key to the correct location
    Copy-Item $sshKeyBackupPath $sshKeyPath -Force
    Write-Host "✅ SSH key copied to: $sshKeyPath" -ForegroundColor Green
} else {
    Write-Host "❌ No SSH key found. Please check your key files." -ForegroundColor Red
    exit 1
}

# Step 2: Set correct permissions (Windows equivalent)
Write-Host ""
Write-Host "Step 2: Setting correct permissions..." -ForegroundColor Yellow

try {
    # Remove inheritance and set owner-only permissions
    icacls $sshKeyPath /inheritance:r /grant:r "$env:USERNAME:(R)" /c
    Write-Host "✅ Set restrictive permissions on SSH key" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Could not set permissions: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Step 3: Check SSH config
Write-Host ""
Write-Host "Step 3: Checking SSH configuration..." -ForegroundColor Yellow

$sshConfigPath = "$env:USERPROFILE\.ssh\config"
$sshConfigSource = "c:\Users\reube\alx-system_engineering-devops\0x0B-ssh\2-ssh_config"

if (Test-Path $sshConfigSource) {
    Copy-Item $sshConfigSource $sshConfigPath -Force
    Write-Host "✅ SSH config copied to: $sshConfigPath" -ForegroundColor Green
} else {
    Write-Host "⚠️  Creating basic SSH config..." -ForegroundColor Yellow
    @"
Host *
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
    PubkeyAuthentication yes
    IdentitiesOnly yes
"@ | Out-File -FilePath $sshConfigPath -Encoding UTF8
    Write-Host "✅ Basic SSH config created" -ForegroundColor Green
}

# Step 4: Test SSH connection
Write-Host ""
Write-Host "Step 4: Testing SSH connection..." -ForegroundColor Yellow
Write-Host "Please provide your server details:" -ForegroundColor Cyan

$serverIP = Read-Host "Enter your web-01 server IP address"
$username = Read-Host "Enter your username (default: ubuntu)" 
if ([string]::IsNullOrEmpty($username)) { $username = "ubuntu" }

Write-Host ""
Write-Host "Testing connection to $username@$serverIP..." -ForegroundColor Yellow

# Test SSH connection
$sshCommand = "ssh -i `"$sshKeyPath`" -o ConnectTimeout=10 -o StrictHostKeyChecking=no $username@$serverIP echo 'SSH connection successful!'"

Write-Host "Running: $sshCommand" -ForegroundColor Gray
try {
    $result = Invoke-Expression $sshCommand
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ SSH connection successful!" -ForegroundColor Green
        Write-Host $result -ForegroundColor Green
    } else {
        Write-Host "❌ SSH connection failed. Exit code: $LASTEXITCODE" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ SSH connection error: $($_.Exception.Message)" -ForegroundColor Red
}

# Step 5: Alternative solutions
Write-Host ""
Write-Host "=== Alternative Solutions ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "If SSH still fails, try these alternatives:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. ALX Web Terminal (RECOMMENDED):" -ForegroundColor White
Write-Host "   - Log into https://intranet.alxswe.com/" -ForegroundColor Gray
Write-Host "   - Navigate to your project: 0x18-webstack_monitoring" -ForegroundColor Gray
Write-Host "   - Click 'Webterm' or 'Terminal' to access web-01" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Check public key on server:" -ForegroundColor White
Write-Host "   - Your public key might not be in ~/.ssh/authorized_keys on the server" -ForegroundColor Gray
Write-Host "   - Contact ALX support for assistance" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Generate new SSH key pair:" -ForegroundColor White
Write-Host "   - Run: ssh-keygen -t rsa -b 4096 -f ~/.ssh/school" -ForegroundColor Gray
Write-Host "   - Copy public key to server: ssh-copy-id -i ~/.ssh/school.pub $username@$serverIP" -ForegroundColor Gray

Write-Host ""
Write-Host "=== Next Steps for Datadog Setup ===" -ForegroundColor Green
Write-Host ""
Write-Host "Once SSH access is working, run these commands on web-01:" -ForegroundColor Yellow
Write-Host ""
Write-Host "# Install Datadog Agent" -ForegroundColor Gray
Write-Host "DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE=`"datadoghq.com`" bash -c `"`$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)`"" -ForegroundColor Gray
Write-Host ""
Write-Host "# Set hostname" -ForegroundColor Gray
Write-Host "sudo hostnamectl set-hostname XX-web-01" -ForegroundColor Gray
Write-Host ""
Write-Host "# Restart agent" -ForegroundColor Gray
Write-Host "sudo systemctl restart datadog-agent" -ForegroundColor Gray
Write-Host "sudo systemctl enable datadog-agent" -ForegroundColor Gray

Write-Host ""
Write-Host "Script completed! Check the output above for next steps." -ForegroundColor Green
