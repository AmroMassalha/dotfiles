#!/bin/bash

# Function to extract and log the status of a network interface
get_interface_status() {
    local interface=$1
    local status=$(ifconfig $interface | grep 'status: active')

    if [[ -n "$status" ]]; then
        echo 'connected'
    else
        echo 'disconnected'
    fi
}

# Check VPN status by looking for an assigned IP address on the specific utun5 interface
VPN_STATUS="$(ifconfig utun5 | grep -q 'inet ' && echo 'connected' || echo 'disconnected')"

# Check Ethernet status by looking for 'active' on your Ethernet interface (e.g., en1)
ETHERNET_STATUS="$(get_interface_status en1)"

# Check WiFi status by looking for 'active' on the WiFi interface, usually en0
WIFI_STATUS="$(get_interface_status en0)"

# Determine the appropriate icon
if [[ "$VPN_STATUS" == "connected" ]]; then
    ICON="􁅏"  # Icon for VPN connected
elif [[ "$ETHERNET_STATUS" == "connected" ]]; then
    ICON="􀤆"  # Icon for Ethernet connected
elif [[ "$WIFI_STATUS" == "connected" ]]; then
    ICON="􀤆"  # Icon for WiFi connected
else
    ICON="􁣡"  # Icon for no network connection
fi

# Update the Sketchybar item
sketchybar --set "$NAME" icon="$ICON"
