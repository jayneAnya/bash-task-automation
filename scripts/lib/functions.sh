#!/usr/bin/env bash

# Print a section header
print_header() {
    local title="$1"

    echo
    echo "=============================="
    echo "$title"
    echo "=============================="
}

# Check whether a numeric value is below a threshold
check_threshold() {
    local metric_name="$1"
    local current_value="$2"
    local threshold="$3"

    if (( current_value >= threshold )); then
        echo "WARNING: $metric_name is ${current_value}, which is at or above the threshold of ${threshold}."
        return 1
    else
        echo "OK: $metric_name is ${current_value}, which is below the threshold of ${threshold}."
        return 0
    fi
}

# Display a key-value pair
display_metric() {
    local metric_name="$1"
    local metric_value="$2"

    echo "$metric_name: $metric_value"
}