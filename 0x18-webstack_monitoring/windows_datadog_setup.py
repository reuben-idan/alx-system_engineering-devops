#!/usr/bin/env python3
"""
Windows-compatible Datadog setup for ALX project
Uses requests library instead of curl for Windows compatibility
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
BASE_URL = f"https://api.{DD_SITE}"

def make_api_request(endpoint, method="GET", data=None):
    """Make API request with proper headers"""
    headers = {
        'DD-API-KEY': DD_API_KEY,
        'DD-APPLICATION-KEY': DD_APP_KEY,
        'Content-Type': 'application/json'
    }
    
    url = f"{BASE_URL}{endpoint}"
    
    try:
        if method == "GET":
            response = requests.get(url, headers=headers, timeout=30)
        elif method == "POST":
            response = requests.post(url, headers=headers, json=data, timeout=30)
        else:
            print(f"Unsupported method: {method}")
            return None
        
        print(f"API Request: {method} {endpoint} - Status: {response.status_code}")
        
        if response.status_code in [200, 201]:
            return response.json() if response.text.strip() else {}
        else:
            print(f"API Error: {response.status_code} - {response.text}")
            return None
            
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")
        return None

def validate_credentials():
    """Validate API credentials"""
    print("🔑 Validating API credentials...")
    
    response = make_api_request("/api/v1/validate")
    if response is not None:
        print("✅ API credentials are valid")
        return True
    else:
        print("❌ API credentials validation failed")
        return False

def check_host_status():
    """Check if host is visible in Datadog"""
    print("🔍 Checking host status...")
    
    response = make_api_request("/api/v1/hosts")
    if response and 'host_list' in response:
        hosts = response['host_list']
        for host in hosts:
            if host.get('name') == HOSTNAME:
                print(f"✅ Host {HOSTNAME} found in Datadog")
                return True
        print(f"❌ Host {HOSTNAME} not found in Datadog")
        print("Note: Host may need time to appear after agent installation")
        return False
    else:
        print("❌ Failed to check host status")
        return False

def create_monitor(name, query, message):
    """Create a monitor"""
    print(f"Creating monitor: {name}")
    
    monitor_data = {
        "type": "metric alert",
        "query": query,
        "name": name,
        "message": message,
        "options": {
            "thresholds": {
                "critical": 100,
                "warning": 50
            },
            "notify_no_data": False,
            "renotify_interval": 0
        }
    }
    
    response = make_api_request("/api/v1/monitor", "POST", monitor_data)
    if response and 'id' in response:
        print(f"✅ Created monitor: {name} (ID: {response['id']})")
        return response['id']
    else:
        print(f"❌ Failed to create monitor: {name}")
        return None

def create_dashboard():
    """Create dashboard"""
    print("📈 Creating dashboard...")
    
    dashboard_data = {
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
    
    response = make_api_request("/api/v1/dashboard", "POST", dashboard_data)
    if response and 'id' in response:
        dashboard_id = response['id']
        print(f"✅ Created dashboard: {dashboard_id}")
        
        # Save to file
        try:
            with open('2-setup_datadog', 'w') as f:
                f.write(dashboard_id + '\n')
            print(f"✅ Dashboard ID saved to 2-setup_datadog")
        except Exception as e:
            print(f"❌ Failed to save dashboard ID: {e}")
        
        return dashboard_id
    else:
        print("❌ Failed to create dashboard")
        return None

def verify_file():
    """Verify the answer file exists and has content"""
    print("📄 Verifying answer file...")
    
    if os.path.exists('2-setup_datadog'):
        with open('2-setup_datadog', 'r') as f:
            content = f.read().strip()
            if content and content != "abc-def-ghi":
                print(f"✅ Answer file contains: {content}")
                return True
            else:
                print("❌ Answer file has placeholder content")
                return False
    else:
        print("❌ Answer file does not exist")
        return False

def main():
    """Main execution"""
    print("🚀 ALX 0x18-webstack_monitoring Windows Setup")
    print("=" * 50)
    
    # Validate credentials
    if not validate_credentials():
        print("❌ Cannot proceed without valid API credentials")
        return False
    
    # Check host status
    host_ok = check_host_status()
    
    # Create monitors
    print("\n📊 Creating monitors...")
    read_monitor = create_monitor(
        "High Disk Read Requests per Second",
        f"avg(last_5m):avg:system.io.r_s{{host:{HOSTNAME}}} > 100",
        f"High disk read requests on {HOSTNAME}"
    )
    
    write_monitor = create_monitor(
        "High Disk Write Requests per Second", 
        f"avg(last_5m):avg:system.io.w_s{{host:{HOSTNAME}}} > 100",
        f"High disk write requests on {HOSTNAME}"
    )
    
    # Create dashboard
    print("\n📈 Creating dashboard...")
    dashboard_id = create_dashboard()
    
    # Verify file
    file_ok = verify_file()
    
    # Summary
    print("\n" + "=" * 50)
    print("📋 ALX PROJECT COMPLETION SUMMARY")
    print("=" * 50)
    print(f"✅ API Credentials: Valid")
    print(f"{'✅' if host_ok else '⚠️'} Host Status: {'Found' if host_ok else 'Not found (may need time)'}")
    print(f"{'✅' if read_monitor else '❌'} Read Monitor: {'Created' if read_monitor else 'Failed'}")
    print(f"{'✅' if write_monitor else '❌'} Write Monitor: {'Created' if write_monitor else 'Failed'}")
    print(f"{'✅' if dashboard_id else '❌'} Dashboard: {'Created' if dashboard_id else 'Failed'}")
    print(f"{'✅' if file_ok else '❌'} Answer File: {'Valid' if file_ok else 'Invalid'}")
    
    if dashboard_id and file_ok:
        print(f"\n🎉 ALX PROJECT COMPLETED SUCCESSFULLY!")
        print(f"Dashboard URL: https://app.{DD_SITE}/dashboard/{dashboard_id}")
        print(f"Answer file '2-setup_datadog' contains: {dashboard_id}")
        return True
    else:
        print("\n❌ Project incomplete - check errors above")
        return False

if __name__ == "__main__":
    try:
        success = main()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n❌ Setup interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Unexpected error: {e}")
        sys.exit(1)
