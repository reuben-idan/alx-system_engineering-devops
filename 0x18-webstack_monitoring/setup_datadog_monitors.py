#!/usr/bin/env python3
"""
Script to set up Datadog monitors and dashboard via API
Requires: pip install datadog
"""

import os
from datadog import initialize, api

# Configuration
DD_API_KEY = "7539ebebc75033fb4dc7c82d753bcb4a"
DD_APP_KEY = "YOUR_APPLICATION_KEY_HERE"  # Replace with your actual app key

def setup_datadog():
    """Initialize Datadog API"""
    options = {
        'api_key': DD_API_KEY,
        'app_key': DD_APP_KEY
    }
    initialize(**options)

def create_disk_read_monitor():
    """Create monitor for disk read requests per second"""
    monitor_options = {
        "type": "metric alert",
        "query": "avg(last_5m):avg:system.io.r_s{host:XX-web-01} > 100",
        "name": "High Disk Read Requests per Second",
        "message": "Disk read requests are high on {{host.name}} @slack-alerts",
        "tags": ["env:production", "service:webstack"],
        "options": {
            "thresholds": {
                "critical": 100,
                "warning": 50
            },
            "notify_no_data": False,
            "renotify_interval": 0
        }
    }
    
    try:
        response = api.Monitor.create(**monitor_options)
        print(f"✅ Created disk read monitor: {response['id']}")
        return response['id']
    except Exception as e:
        print(f"❌ Failed to create disk read monitor: {e}")
        return None

def create_disk_write_monitor():
    """Create monitor for disk write requests per second"""
    monitor_options = {
        "type": "metric alert",
        "query": "avg(last_5m):avg:system.io.w_s{host:XX-web-01} > 100",
        "name": "High Disk Write Requests per Second",
        "message": "Disk write requests are high on {{host.name}} @slack-alerts",
        "tags": ["env:production", "service:webstack"],
        "options": {
            "thresholds": {
                "critical": 100,
                "warning": 50
            },
            "notify_no_data": False,
            "renotify_interval": 0
        }
    }
    
    try:
        response = api.Monitor.create(**monitor_options)
        print(f"✅ Created disk write monitor: {response['id']}")
        return response['id']
    except Exception as e:
        print(f"❌ Failed to create disk write monitor: {e}")
        return None

def create_dashboard():
    """Create dashboard with system metrics"""
    dashboard_config = {
        "title": "ALX System Monitoring Dashboard",
        "description": "System monitoring dashboard for ALX project",
        "widgets": [
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [
                        {
                            "q": "avg:system.cpu.user{host:XX-web-01}",
                            "display_type": "line",
                            "style": {
                                "palette": "dog_classic",
                                "line_type": "solid",
                                "line_width": "normal"
                            }
                        }
                    ],
                    "title": "CPU Usage",
                    "yaxis": {
                        "label": "",
                        "scale": "linear",
                        "min": "auto",
                        "max": "auto",
                        "include_zero": True
                    }
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [
                        {
                            "q": "avg:system.mem.used{host:XX-web-01}",
                            "display_type": "line",
                            "style": {
                                "palette": "dog_classic",
                                "line_type": "solid",
                                "line_width": "normal"
                            }
                        }
                    ],
                    "title": "Memory Usage",
                    "yaxis": {
                        "label": "",
                        "scale": "linear",
                        "min": "auto",
                        "max": "auto",
                        "include_zero": True
                    }
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [
                        {
                            "q": "avg:system.io.r_s{host:XX-web-01}",
                            "display_type": "line",
                            "style": {
                                "palette": "dog_classic",
                                "line_type": "solid",
                                "line_width": "normal"
                            }
                        }
                    ],
                    "title": "Disk Read Requests/sec",
                    "yaxis": {
                        "label": "",
                        "scale": "linear",
                        "min": "auto",
                        "max": "auto",
                        "include_zero": True
                    }
                }
            },
            {
                "definition": {
                    "type": "timeseries",
                    "requests": [
                        {
                            "q": "avg:system.io.w_s{host:XX-web-01}",
                            "display_type": "line",
                            "style": {
                                "palette": "dog_classic",
                                "line_type": "solid",
                                "line_width": "normal"
                            }
                        }
                    ],
                    "title": "Disk Write Requests/sec",
                    "yaxis": {
                        "label": "",
                        "scale": "linear",
                        "min": "auto",
                        "max": "auto",
                        "include_zero": True
                    }
                }
            }
        ],
        "layout_type": "ordered"
    }
    
    try:
        response = api.Dashboard.create(**dashboard_config)
        dashboard_id = response['id']
        print(f"✅ Created dashboard: {dashboard_id}")
        
        # Save dashboard ID to required file
        with open('2-setup_datadog', 'w') as f:
            f.write(dashboard_id + '\n')
        print(f"✅ Dashboard ID saved to 2-setup_datadog")
        
        return dashboard_id
    except Exception as e:
        print(f"❌ Failed to create dashboard: {e}")
        return None

def main():
    """Main execution function"""
    print("🚀 Setting up Datadog monitors and dashboard...")
    
    # Initialize Datadog API
    setup_datadog()
    
    # Create monitors
    print("\n📊 Creating monitors...")
    read_monitor_id = create_disk_read_monitor()
    write_monitor_id = create_disk_write_monitor()
    
    # Create dashboard
    print("\n📈 Creating dashboard...")
    dashboard_id = create_dashboard()
    
    print("\n✅ Setup complete!")
    print(f"Dashboard ID: {dashboard_id}")
    print("Check your Datadog account for the new monitors and dashboard.")

if __name__ == "__main__":
    main()
