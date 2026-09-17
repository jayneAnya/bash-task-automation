#!/usr/bin/env bash

set -euo pipefail

# Base directory for generated files
BASE_DIR="./automation-output"

# Generate a timestamp for dynamically named files
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"

# Create the required directory structure
create_directories() {
    mkdir -p "$BASE_DIR/logs"
    mkdir -p "$BASE_DIR/reports"
    mkdir -p "$BASE_DIR/data"

    echo "Directory structure created successfully."
}

# Create a timestamped report file
create_report() {
    local REPORT_FILE="$BASE_DIR/reports/report_${TIMESTAMP}.txt"

    touch "$REPORT_FILE"

    echo "System Automation Report" > "$REPORT_FILE"
    echo "Generated on: $(date)" >> "$REPORT_FILE"
    echo "Hostname: $(hostname)" >> "$REPORT_FILE"

    echo "Report created successfully: $REPORT_FILE"
}

# Create a data file with sample content
create_data_file() {
    local DATA_FILE="$BASE_DIR/data/system_info.txt"

    if [[ ! -f "$DATA_FILE" ]]; then
        touch "$DATA_FILE"
        echo "System information data file" > "$DATA_FILE"
        echo "Created on: $(date)" >> "$DATA_FILE"

        echo "Data file created successfully: $DATA_FILE"
    else
        echo "Data file already exists: $DATA_FILE"
    fi
}

# Main function
main() {
    echo "Starting directory and file automation..."

    create_directories
    create_report
    create_data_file

    echo "Directory and file automation completed successfully."
}

main "$@"