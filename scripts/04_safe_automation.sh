#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# Cleanup function
cleanup() {
    echo
    echo "Cleaning up temporary resources..."
}

# Handle script interruption
handle_interrupt() {
    echo
    echo "Script interrupted."
    exit 130
}

# Register signal handlers
trap cleanup EXIT
trap handle_interrupt INT TERM

# Validate that a required argument was provided
validate_arguments() {
    if [[ $# -lt 1 ]]; then
        echo "Error: A directory path is required."
        echo "Usage: $0 <directory>"
        exit 1
    fi
}

# Validate the provided directory
validate_directory() {
    local target_dir="$1"

    if [[ -z "$target_dir" ]]; then
        echo "Error: Directory path cannot be empty."
        exit 1
    fi

    if [[ ! -e "$target_dir" ]]; then
        echo "Error: Path does not exist: $target_dir"
        exit 1
    fi

    if [[ ! -d "$target_dir" ]]; then
        echo "Error: Path is not a directory: $target_dir"
        exit 1
    fi

    echo "Directory validation successful: $target_dir"
}

# Create a temporary file
create_temporary_file() {
    local target_dir="$1"
    local temporary_file="$target_dir/automation_temp.txt"

    echo "Creating temporary file: $temporary_file"

    touch "$temporary_file"
    echo "Temporary automation file" > "$temporary_file"

    echo "Temporary file created successfully."
}

main() {
    validate_arguments "$@"

    local target_dir="$1"

    validate_directory "$target_dir"
    create_temporary_file "$target_dir"

    echo "Safe automation completed successfully."
}

main "$@"