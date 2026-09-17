#!/usr/bin/env bash

set -euo pipefail

# Load reusable functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/functions.sh"

# Configuration
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
PROCESS_THRESHOLD=200

# Collect system information
get_system_information() {
    local hostname
    local uptime
    local disk_usage
    local memory_usage
    local process_count

    hostname="$(hostname)"
    uptime="$(uptime -p)"
    disk_usage="$(df / | awk 'NR==2 {print $5}' | tr -d '%')"
    memory_usage="$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')"
    process_count="$(ps -e --no-headers | wc -l)"

    display_metric "Hostname" "$hostname"
    display_metric "Uptime" "$uptime"
    display_metric "Disk Usage" "${disk_usage}%"
    display_metric "Memory Usage" "${memory_usage}%"
    display_metric "Running Processes" "$process_count"

    echo

    check_threshold "Disk Usage" "$disk_usage" "$DISK_THRESHOLD" || true
    check_threshold "Memory Usage" "$memory_usage" "$MEMORY_THRESHOLD" || true
    check_threshold "Process Count" "$process_count" "$PROCESS_THRESHOLD" || true
}

main() {
    print_header "System Health Monitor"

    get_system_information

    print_header "Health Check Complete"
}

main "$@"