#!/usr/bin/env python3
"""
Simplified Datadog setup for ALX project
Uses curl commands to avoid Python API authentication issues
"""

import subprocess
import json
import sys

# Configuration
DD_API_KEY = "7539ebebc75033fb4dc7c82d753bcb4a"
DD_APP_KEY = "bc5c466ed68251d49653d7eca05c852a"
DD_SITE = "datadoghq.com"
HOSTNAME = "XX-web-01"

def run_curl_command(url, method="GET", data=None):
    """Run curl command with proper headers"""
    headers = [
        f"DD-API-KEY: {DD_API_KEY}",
        f"DD-APPLICATION-KEY: {DD_APP_KEY}",
        "Content-Type: application/json"
    ]
    
    cmd = ["curl", "-X", method]
    for header in headers:
        cmd.extend(["-H", header])
    
    if data:
        cmd.extend(["-d", json.dumps(data)])
    
    cmd.append(f"https://api.{DD_SITE}{url}")
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return json.loads(result.stdout) if result.stdout.strip() else {}
        else:
            print(f"Curl command failed: {result.stderr}")
            return None
    except Exception as e:
        print(f"Error running curl: {e}")
        return None

def check_host_status():
    """Check if host is visible in Datadog"""
    print("🔍 Checking host status...")
    
    response = run_curl_command("/api/v1/hosts")
    if response and 'host_list' in response:
        hosts = response['host_list']
        for host in hosts:
            if host.get('name') == HOSTNAME:
                print(f"✅ Host {HOSTNAME} found in Datadog")
                return True
        print(f"❌ Host {HOSTNAME} not found in Datadog")
        return False
    else:
        print("❌ Failed to check host status")
        return False

def create_monitor(name, query, message):
    """Create a monitor using curl"""
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
    
    response = run_curl_command("/api/v1/monitor", "POST", monitor_data)
    if response and 'id' in response:
        print(f"✅ Created monitor: {name} (ID: {response['id']})")
        return response['id']
    else:
        print(f"❌ Failed to create monitor: {name}")
        return None

def create_dashboard():
    """Create dashboard using curl"""
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
            }
        ],
        "layout_type": "ordered"
    }
    
    response = run_curl_command("/api/v1/dashboard", "POST", dashboard_data)
    if response and 'id' in response:
        dashboard_id = response['id']
        print(f"✅ Created dashboard: {dashboard_id}")
        
        # Save to file
        with open('2-setup_datadog', 'w') as f:
            f.write(dashboard_id + '\n')
        print(f"✅ Dashboard ID saved to 2-setup_datadog")
        return dashboard_id
    else:
        print("❌ Failed to create dashboard")
        return None

def main():
    """Main execution"""
    print("🚀 ALX 0x18-webstack_monitoring Setup (Simplified)")
    print("=" * 50)
    
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
    
    # Summary
    print("\n" + "=" * 50)
    print("📋 SETUP SUMMARY")
    print("=" * 50)
    print(f"Host Status: {'✅ OK' if host_ok else '❌ FAILED'}")
    print(f"Read Monitor: {'✅ OK' if read_monitor else '❌ FAILED'}")
    print(f"Write Monitor: {'✅ OK' if write_monitor else '❌ FAILED'}")
    print(f"Dashboard: {'✅ OK' if dashboard_id else '❌ FAILED'}")
    
    if dashboard_id:
        print(f"\n🎉 SUCCESS! Dashboard ID: {dashboard_id}")
        print(f"Dashboard URL: https://app.{DD_SITE}/dashboard/{dashboard_id}")
        return True
    else:
        print("\n❌ Setup incomplete")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
