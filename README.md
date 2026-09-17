# Bash Task Automation

A beginner-focused Bash scripting project demonstrating Linux automation, system monitoring, modular programming, defensive scripting, and professional repository organization.

## Project Overview

This project introduces Bash scripting as a foundation for DevOps automation in Linux environments.

The project focuses on transforming manual command execution into reusable, safe, and maintainable automation scripts.

## Project Objectives

- Automate directory and file creation
- Monitor basic system health
- Use Bash functions and external function libraries
- Implement input validation and defensive scripting
- Handle script interruptions using traps
- Demonstrate professional repository organization
- Practice idempotent automation

## Project Structure

```text
bash-task-automation/
├── docs/
│   └── project-summary.md
├── screenshots/
├── scripts/
│   ├── 01_directory_file_creation.sh
│   ├── 02_system_health_monitor.sh
│   ├── 03_functions.sh
│   ├── 04_safe_automation.sh
│   └── lib/
│       └── functions.sh
├── COMPLETION_CHECKLIST.md
├── README.md
└── .gitignore


Tasks Completed
Task 1: Directory and File Automation

The first script creates a nested directory structure and generates files using Bash commands.

Key concepts demonstrated:

mkdir -p
touch
echo
Variables
Command substitution
Timestamp-based filenames
Conditional file checks
Idempotent directory creation

Script:

scripts/01_directory_file_creation.sh
Task 2: System Health Monitor

The second script collects basic system information and compares resource usage against configured thresholds.

The script monitors:

Disk usage
Memory usage
Running processes
Hostname
System uptime

Commands used include:

df
free
ps
uptime
awk
tr

The script uses exit codes to communicate health status.

Exit code 0 indicates a healthy system.

Exit code 1 indicates that one or more configured thresholds have been exceeded.

Script:

scripts/02_system_health_monitor.sh
Task 3: Modular Bash Functions

The third task refactors reusable functionality into an external Bash function library.

Concepts demonstrated:

Functions
Function arguments
$1, $2, and $3
local variables
source
Reusable function libraries

Files:

scripts/03_functions.sh
scripts/lib/functions.sh
Task 4: Input Validation and Script Safety

The fourth script demonstrates defensive Bash scripting.

Safety mechanisms include:

set -e
set -u
set -o pipefail

The script validates:

Required arguments
Empty input
Path existence
Directory type

Signal handling is implemented using trap.

Script:

scripts/04_safe_automation.sh
Testing

Each script was executed from the project root.

Example:

./scripts/01_directory_file_creation.sh
./scripts/02_system_health_monitor.sh
./scripts/03_functions.sh
./scripts/04_safe_automation.sh automation-output

Invalid input was also tested to verify that the safety checks correctly reject invalid paths and missing arguments.

Bash Concepts Demonstrated
Variables
Command substitution
Conditional statements
Functions
Function arguments
Local variables
Exit codes
Input validation
Error handling
Signal trapping
Idempotent operations
External function libraries
Linux system commands
Technologies
Bash
Linux
Git
GitHub
Evidence

Execution screenshots are stored in:

screenshots/

The screenshots provide evidence of successful execution and validation tests.


---

## 3. Project summary

Open:

```bash
code docs/project-summary.md

Use:

# Project Summary

## Purpose

This project provides hands-on experience with Bash scripting for Linux and DevOps automation.

The exercises progress from basic filesystem automation to system monitoring, modular scripting, and defensive programming.

## Task 1

The directory and file automation script creates a predefined directory hierarchy and generates timestamped reports.

The script uses `mkdir -p` to allow directory creation to be repeated safely.

Conditional checks are used when creating persistent files.

## Task 2

The system health monitor collects system metrics using standard Linux utilities.

Disk, memory, and process usage are compared against configurable thresholds.

The script returns an exit code based on the overall health status.

## Task 3

Reusable Bash functions are separated into an external library.

The main script loads the library using `source` and passes arguments to reusable functions.

This improves maintainability and reduces duplicated logic.

## Task 4

The safe automation script demonstrates defensive programming.

It uses:

- `set -e`
- `set -u`
- `set -o pipefail`
- Input validation
- Path validation
- Signal handling
- Cleanup using `trap`

Invalid input scenarios were tested to confirm that the script fails safely.

## Results

All four scripting tasks were successfully implemented and tested.

The scripts execute successfully under Bash and demonstrate fundamental automation techniques relevant to Linux administration and DevOps workflows.
