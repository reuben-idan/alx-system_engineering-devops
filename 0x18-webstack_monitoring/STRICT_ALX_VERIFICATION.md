# ALX 0x18-webstack_monitoring - STRICT REQUIREMENTS VERIFICATION

## TASK 0: Sign up for Datadog and install datadog-agent

### Requirement Checklist:

#### ✅ 1. Sign up for Datadog (US website)
- **Required**: Use https://app.datadoghq.com (US1 region)
- **Status**: ✅ COMPLETE
- **Evidence**: API Key obtained: 7539ebebc75033fb4dc7c82d753bcb4a

#### ⚠️ 2. Install datadog-agent on web-01
- **Required**: Agent must be installed and running on web-01 (54.161.202.254)
- **Status**: ⚠️ NEEDS EXECUTION
- **Action Required**: SSH to web-01 and run installation
- **Script Ready**: `complete_datadog_setup.sh`

#### ✅ 3. Create an application key
- **Required**: Application key for API access
- **Status**: ✅ COMPLETE
- **Evidence**: Application Key: bc5c466ed68251d49653d7eca05c852a

#### ⚠️ 4. Server visibility as XX-web-01
- **Required**: web-01 must appear in Datadog Infrastructure with hostname XX-web-01
- **Status**: ⚠️ PENDING AGENT INSTALLATION
- **Verification**: Check https://app.datadoghq.com/infrastructure

#### ⚠️ 5. API Validation
- **Required**: Validate using Datadog API
- **Status**: ⚠️ PENDING AGENT INSTALLATION
- **API Endpoint**: https://api.datadoghq.com/api/v1/hosts

## TASK 1: Monitor some metrics

### Requirement Checklist:

#### ⚠️ 1. Read Requests Monitor
- **Required**: Monitor for `system.io.r_s` (read requests per second)
- **Status**: ⚠️ NEEDS MANUAL CREATION
- **Action**: Create in Datadog UI at https://app.datadoghq.com/monitors/create

#### ⚠️ 2. Write Requests Monitor  
- **Required**: Monitor for `system.io.w_s` (write requests per second)
- **Status**: ⚠️ NEEDS MANUAL CREATION
- **Action**: Create in Datadog UI at https://app.datadoghq.com/monitors/create

## TASK 2: Create a dashboard

### Requirement Checklist:

#### ✅ 1. Dashboard Creation
- **Required**: New dashboard with 4+ widgets
- **Status**: ✅ COMPLETE
- **Evidence**: Dashboard ID: 97u-ndh-2fe

#### ✅ 2. Answer File
- **Required**: File `2-setup_datadog` with dashboard_id on first line
- **Status**: ✅ COMPLETE
- **Evidence**: File contains `97u-ndh-2fe`

## CRITICAL GAPS IDENTIFIED

### 🚨 IMMEDIATE ACTIONS REQUIRED:

1. **Install Datadog Agent on web-01**
   ```bash
   ssh ubuntu@54.161.202.254
   DD_API_KEY=7539ebebc75033fb4dc7c82d753bcb4a DD_SITE="datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
   sudo hostnamectl set-hostname XX-web-01
   sudo sed -i "s/# hostname:.*/hostname: XX-web-01/" /etc/datadog-agent/datadog.yaml
   sudo systemctl restart datadog-agent
   ```

2. **Verify Server Visibility**
   - Go to: https://app.datadoghq.com/infrastructure
   - Confirm XX-web-01 appears in host list

3. **Create Required Monitors**
   - Go to: https://app.datadoghq.com/monitors/create
   - Create monitor for `system.io.r_s{host:XX-web-01}`
   - Create monitor for `system.io.w_s{host:XX-web-01}`

## COMPLIANCE STATUS

### Current Completion: 40% ⚠️

- ✅ Datadog account setup
- ✅ API/Application keys obtained  
- ✅ Dashboard created and ID saved
- ❌ Agent not installed on web-01
- ❌ Server not visible as XX-web-01
- ❌ Monitors not created

### To Achieve 100% Compliance:
1. Execute agent installation on web-01
2. Verify hostname appears as XX-web-01
3. Create 2 required monitors
4. Verify all components working

## VERIFICATION COMMANDS

After completing the actions above, verify with:

```bash
# Check agent status
ssh ubuntu@54.161.202.254 "sudo datadog-agent status"

# Verify hostname
ssh ubuntu@54.161.202.254 "hostname"

# API validation
curl -X GET "https://api.datadoghq.com/api/v1/hosts" \
  -H "DD-API-KEY: 7539ebebc75033fb4dc7c82d753bcb4a" \
  -H "DD-APPLICATION-KEY: bc5c466ed68251d49653d7eca05c852a"
```

## NEXT STEPS FOR FULL COMPLIANCE

1. **CRITICAL**: Install agent on web-01 (required for 0% → 100%)
2. **CRITICAL**: Create 2 monitors (required for task completion)
3. **VERIFY**: All requirements met before submission
