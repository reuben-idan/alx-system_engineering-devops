#!/usr/bin/env python3
"""
ALX 0x18-webstack_monitoring Project Verification Script
Verifies all project requirements are met and creates necessary deliverables
"""

import requests
import json
import sys
import os

# Configuration
DD_API_KEY = "7539ebebc75033fb4dc7c82d753bcb4a"
DD_APP_KEY = "bc5c466ed68251d49653d7eca05c852a"
DD_SITE = "datadoghq.com"
HOSTNAME = "XX-web-01"

def check_agent_status():
    """Check if Datadog agent is running and reporting"""
    print("🔍 Checking Datadog Agent status...")
    
    # Check via API
    url = f"https://api.{DD_SITE}/api/v1/hosts"
    headers = {
        'DD-API-KEY': DD_API_KEY,
        'DD-APPLICATION-KEY': DD_APP_KEY
    }
    
    try:
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            hosts = response.json().get('host_list', [])
            for host in hosts:
                if host.get('name') == HOSTNAME:
                    print(f"✅ Host {HOSTNAME} found in Datadog")
                    return True
            print(f"❌ Host {HOSTNAME} not found in Datadog")
            return False
        else:
            print(f"❌ API request failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Error checking agent status: {e}")
        return False

def create_monitors():
    """Create required monitors for disk I/O"""
    print("📊 Creating Datadog monitors...")
    
    monitors = [
        {
            "name": "Disk Read Requests per Second",
            "type": "metric alert",
            "query": f"avg(last_5m):avg:system.io.r_s{{host:{HOSTNAME}}} > 100",
            "message": f"High disk read requests on {HOSTNAME} @slack-alerts",
            "options": {
                "thresholds": {"critical": 100, "warning": 50},
                "notify_no_data": False
            }
        },
        {
            "name": "Disk Write Requests per Second", 
            "type": "metric alert",
            "query": f"avg(last_5m):avg:system.io.w_s{{host:{HOSTNAME}}} > 100",
            "message": f"High disk write requests on {HOSTNAME} @slack-alerts",
            "options": {
                "thresholds": {"critical": 100, "warning": 50},
                "notify_no_data": False
            }
        }
    ]
    
    created_monitors = []
    for monitor in monitors:
        try:
            url = f"https://api.{DD_SITE}/api/v1/monitor"
            headers = {
                'DD-API-KEY': DD_API_KEY,
                'DD-APPLICATION-KEY': DD_APP_KEY,
                'Content-Type': 'application/json'
            }
            
            response = requests.post(url, headers=headers, json=monitor)
            if response.status_code == 200:
                monitor_data = response.json()
                print(f"✅ Created monitor: {monitor['name']} (ID: {monitor_data['id']})")
                created_monitors.append(monitor_data['id'])
            else:
                print(f"❌ Failed to create monitor {monitor['name']}: {response.status_code}")
        except Exception as e:
            print(f"❌ Error creating monitor {monitor['name']}: {e}")
    
    return created_monitors

def create_dashboard():
    """Create dashboard with required widgets"""
    print("📈 Creating Datadog dashboard...")
    
    dashboard_config = {
        "title": "ALX System Monitoring Dashboard",
        "description": "ALX 0x18-webstack_monitoring project dashboard",
        "widgets": [
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [{"q": f"avg:system.cpu.user{{host:{HOSTNAME}}}"}],
                    "title": "CPU Usage"
                }
            },
            {
                "definition": {
                    "type": "timeseries", 
                    "requests": [{"q": f"avg:system.mem.used{{host:{HOSTNAME}}}"}],
                    "title": "Memory Usage"
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [{"q": f"avg:system.io.r_s{{host:{HOSTNAME}}}"}],
                    "title": "Disk Read Requests/sec"
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [{"q": f"avg:system.io.w_s{{host:{HOSTNAME}}}"}],
                    "title": "Disk Write Requests/sec"
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [{"q": f"avg:system.load.1{{host:{HOSTNAME}}}"}],
                    "title": "System Load Average"
                }
            }
        ],
        "layout_type": "ordered"
    }
    
    try:
        url = f"https://api.{DD_SITE}/api/v1/dashboard"
        headers = {
            'DD-API-KEY': DD_API_KEY,
            'DD-APPLICATION-KEY': DD_APP_KEY,
            'Content-Type': 'application/json'
        }
        
        response = requests.post(url, headers=headers, json=dashboard_config)
        if response.status_code == 200:
            dashboard_data = response.json()
            dashboard_id = dashboard_data['id']
            print(f"✅ Created dashboard: {dashboard_id}")
            
            # Save dashboard ID to required file
            with open('2-setup_datadog', 'w') as f:
                f.write(dashboard_id + '\n')
            print(f"✅ Dashboard ID saved to 2-setup_datadog")
            
            return dashboard_id
        else:
            print(f"❌ Failed to create dashboard: {response.status_code}")
            print(f"Response: {response.text}")
            return None
    except Exception as e:
        print(f"❌ Error creating dashboard: {e}")
        return None

def verify_deliverables():
    """Verify all project deliverables are present"""
    print("🔍 Verifying project deliverables...")
    
    required_files = [
        '2-setup_datadog'
    ]
    
    all_present = True
    for file in required_files:
        if os.path.exists(file):
            print(f"✅ {file} exists")
            # Check if file has content
            with open(file, 'r') as f:
                content = f.read().strip()
                if content and content != "dashboard-id-placeholder":
                    print(f"✅ {file} has valid content: {content}")
                else:
                    print(f"❌ {file} has placeholder content")
                    all_present = False
        else:
            print(f"❌ {file} missing")
            all_present = False
    
    return all_present

def main():
    """Main verification function"""
    print("🚀 ALX 0x18-webstack_monitoring Project Verification")
    print("=" * 50)
    
    if DD_APP_KEY == "YOUR_APPLICATION_KEY_HERE":
        print("❌ Please update DD_APP_KEY with your actual Datadog Application Key")
        print("Get it from: https://app.datadoghq.com/organization-settings/application-keys")
        return False
    
    # Task 0: Check agent installation
    agent_ok = check_agent_status()
    
    # Task 1: Create monitors
    monitors = create_monitors()
    
    # Task 2: Create dashboard
    dashboard_id = create_dashboard()
    
    # Verify deliverables
    deliverables_ok = verify_deliverables()
    
    print("\n" + "=" * 50)
    print("📋 VERIFICATION SUMMARY")
    print("=" * 50)
    print(f"✅ Agent Status: {'OK' if agent_ok else 'FAILED'}")
    print(f"✅ Monitors Created: {len(monitors)}/2")
    print(f"✅ Dashboard Created: {'OK' if dashboard_id else 'FAILED'}")
    print(f"✅ Deliverables: {'OK' if deliverables_ok else 'FAILED'}")
    
    if agent_ok and len(monitors) == 2 and dashboard_id and deliverables_ok:
        print("\n🎉 ALL TASKS COMPLETED SUCCESSFULLY!")
        print(f"Dashboard URL: https://app.{DD_SITE}/dashboard/{dashboard_id}")
        return True
    else:
        print("\n❌ Some tasks need attention")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
