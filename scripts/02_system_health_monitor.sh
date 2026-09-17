#!/usr/bin/env bash

set -euo pipefail

# Thresholds
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
PROCESS_THRESHOLD=200

# System information
HOSTNAME="$(hostname)"
UPTIME="$(uptime -p)"
DISK_USAGE="$(df / | awk 'NR==2 {print $5}' | tr -d '%')"
MEMORY_USAGE="$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')"
PROCESS_COUNT="$(ps -e --no-headers | wc -l)"

# Display system information
echo "System Health Report"
echo "===================="
echo "Hostname: $HOSTNAME"
echo "Uptime: $UPTIME"
echo "Disk Usage: ${DISK_USAGE}%"
echo "Memory Usage: ${MEMORY_USAGE}%"
echo "Running Processes: $PROCESS_COUNT"
echo

# Health status
HEALTHY=true

# Check disk usage
if (( DISK_USAGE >= DISK_THRESHOLD )); then
    echo "WARNING: Disk usage is above ${DISK_THRESHOLD}%."
    HEALTHY=false
else
    echo "OK: Disk usage is below ${DISK_THRESHOLD}%."
fi

# Check memory usage
if (( MEMORY_USAGE >= MEMORY_THRESHOLD )); then
    echo "WARNING: Memory usage is above ${MEMORY_THRESHOLD}%."
    HEALTHY=false
else
    echo "OK: Memory usage is below ${MEMORY_THRESHOLD}%."
fi

# Check process count
if (( PROCESS_COUNT >= PROCESS_THRESHOLD )); then
    echo "WARNING: Process count is above ${PROCESS_THRESHOLD}."
    HEALTHY=false
else
    echo "OK: Process count is below ${PROCESS_THRESHOLD}."
fi

echo

# Return an appropriate exit code
if [[ "$HEALTHY" == true ]]; then
    echo "Overall Status: HEALTHY"
    exit 0
else
    echo "Overall Status: WARNING"
    exit 1
fi