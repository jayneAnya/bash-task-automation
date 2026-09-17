😂😂 **YOU DON PASS!** 85/100 with a 60% threshold. So the project is already successfully completed.

The feedback is actually very specific: **your implementation is fine; the documentation is what cost you the 15 points.** You don't need to redo the Bash work.

### What the assessor liked

You got full recognition for:

* Directory/file creation
* System checks and conditions
* Functions/modular scripting
* Screenshots/evidence
* General script quality

The only weak area was:

> **Input validation and error handling: Lacks detailed documentation and explanation of key concepts.**

So if this were a portfolio project, I'd improve the documentation rather than touching the scripts.

---

# Let's upgrade the documentation

Your current `docs/project-summary.md` is too brief for what the assessor wants.

Replace it with a more detailed version that explains **what you did, why you did it, how it works, and what the tests demonstrated**.

Open:

```bash
code docs/project-summary.md
```

Replace the content with:

````markdown
# Bash Task Automation - Project Summary

## 1. Project Overview

This project introduces Bash scripting as a foundational DevOps automation skill in Linux environments.

The objective was to transition from manually executing Linux commands to creating reusable, safe, and maintainable automation scripts.

The project covers five major areas:

1. Directory and file automation
2. System health monitoring
3. Functions and modular scripting
4. Input validation and defensive scripting
5. Documentation and repository organization

The scripts were developed, executed, and tested from a Linux environment using Bash.

---

# 2. Task 1 - Directory and File Creation

## Objective

The objective of Task 1 was to automate the creation of a predefined directory hierarchy and dynamically generated files.

## Implementation

The script creates the following structure:

```text
automation-output/
├── data/
├── logs/
└── reports/
````

The script uses:

* `mkdir -p` to create directories
* `touch` to create files
* `echo` to write content
* Variables to avoid hard-coded paths
* `date` for timestamp generation
* Command substitution using `$(...)`
* Conditional checks to determine whether files already exist

## Idempotency

Idempotency means that an automation operation can be executed multiple times without producing an unwanted result or failing because the desired state already exists.

The script uses:

```bash
mkdir -p
```

instead of plain `mkdir`.

The `-p` option allows the command to create parent directories when necessary and does not produce an error when the directory already exists.

A conditional check is also used before creating the persistent data file:

```bash
if [[ ! -f "$DATA_FILE" ]]; then
```

This prevents the script from unnecessarily recreating the file.

## Dynamic File Naming

The script generates a timestamp using:

```bash
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
```

The timestamp is then included in the report filename:

```bash
report_${TIMESTAMP}.txt
```

This demonstrates command substitution and dynamic artifact generation.

## Outcome

The script successfully created the required directory structure and generated timestamped reports.

The script was executed multiple times to verify that the directory creation process remained safe and repeatable.

---

# 3. Task 2 - System Health Monitoring

## Objective

The objective of Task 2 was to collect basic Linux system information and determine whether the system was operating within predefined resource thresholds.

## Metrics Monitored

The script monitors:

* Disk usage
* Memory usage
* Number of running processes
* Hostname
* System uptime

## Linux Commands Used

### Disk Usage

```bash
df /
```

The `df` command reports filesystem disk-space usage.

The script extracts the percentage used and removes the `%` symbol so that the value can be compared numerically.

### Memory Usage

```bash
free
```

The `free` command provides information about system memory usage.

The script calculates the percentage of memory currently being used.

### Processes

```bash
ps -e
```

The `ps` command displays running processes.

The script counts the processes to determine the current process count.

### System Uptime

```bash
uptime -p
```

This provides a human-readable representation of how long the system has been running.

## Thresholds

The script defines configurable thresholds:

```bash
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
PROCESS_THRESHOLD=200
```

The values collected from the system are compared against these thresholds using Bash conditional statements.

For example:

```bash
if (( DISK_USAGE >= DISK_THRESHOLD )); then
```

If a metric exceeds or reaches its threshold, the script reports a warning.

## Exit Codes

The script uses exit codes to communicate the result of the health check.

```bash
exit 0
```

indicates that the system passed the configured health checks.

```bash
exit 1
```

indicates that one or more configured thresholds were exceeded.

Exit codes are important in DevOps because other automation systems, including CI/CD pipelines, can use them to determine whether a command or job succeeded.

## Outcome

The system health monitor was executed successfully.

The test environment reported:

```text
Disk Usage: 1%
Memory Usage: 30%
Running Processes: 71
Overall Status: HEALTHY
Exit code: 0
```

The values were below the configured thresholds, so the script correctly returned exit code `0`.

---

# 4. Task 3 - Functions and Modular Scripting

## Objective

The objective of Task 3 was to refactor Bash logic into reusable functions and demonstrate modular scripting.

## Function Library

A separate function library was created:

```text
scripts/lib/functions.sh
```

The main script loads the library using:

```bash
source "$SCRIPT_DIR/lib/functions.sh"
```

This allows functions defined in the external file to be reused by the main script.

## Functions Implemented

### `print_header`

Displays formatted section headers.

### `check_threshold`

Accepts three arguments:

```text
$1 - metric name
$2 - current value
$3 - threshold
```

For example:

```bash
check_threshold "Disk Usage" 50 80
```

The function compares the current value with the supplied threshold.

### `display_metric`

Accepts a metric name and value and displays them in a consistent format.

## Function Arguments

Bash functions can receive positional arguments.

For example:

```bash
local metric_name="$1"
local current_value="$2"
local threshold="$3"
```

This allows the same function to work with different values instead of hard-coding individual metrics.

## Local Variables

The `local` keyword is used to limit variables to the scope of the function.

For example:

```bash
local target_dir="$1"
```

This helps prevent functions from unintentionally modifying global variables.

## Outcome

The modular script successfully loaded the external function library and executed the reusable functions.

This structure makes the scripts easier to maintain, extend, and reuse.

---

# 5. Task 4 - Input Validation and Defensive Scripting

## Objective

The objective of Task 4 was to make the automation safer by validating user input, handling errors, and responding appropriately to script interruptions.

This task demonstrates defensive programming, which is particularly important in DevOps automation because scripts may execute against production systems, infrastructure, CI/CD environments, or deployment processes.

---

## Defensive Bash Settings

The script uses:

```bash
set -e
set -u
set -o pipefail
```

These settings make the script more defensive.

### `set -e`

`set -e` causes the script to exit when a command returns a non-zero exit status.

This helps prevent the script from continuing after an unexpected failure.

For example, if a required command fails, subsequent commands should not continue blindly using an invalid result.

### `set -u`

`set -u` causes the script to treat references to unset variables as errors.

Without this setting, a misspelled or undefined variable could expand to an empty value and potentially cause unexpected behavior.

For example:

```bash
echo "$UNDEFINED_VARIABLE"
```

would cause the script to fail rather than silently continue.

### `set -o pipefail`

Normally, a Bash pipeline primarily reports the exit status of its final command.

For example:

```bash
command1 | command2
```

With `pipefail` enabled, the pipeline is considered unsuccessful if an earlier command fails.

This makes failures in command pipelines easier to detect.

Together, the three settings provide stronger failure detection:

```bash
set -e
set -u
set -o pipefail
```

---

# 6. Input Validation

The script validates user-provided input before performing filesystem operations.

## Required Arguments

The script first checks whether the user supplied a directory path:

```bash
if [[ $# -lt 1 ]]; then
```

If no argument is provided, the script displays usage information and exits.

Example:

```text
Error: A directory path is required.
Usage: ./scripts/04_safe_automation.sh <directory>
```

This prevents the script from attempting to operate on an unspecified path.

---

## Empty Input Validation

The script checks whether the supplied path is empty:

```bash
if [[ -z "$target_dir" ]]; then
```

An empty path is rejected before filesystem operations are performed.

---

## Path Existence Validation

The script checks whether the supplied path exists:

```bash
if [[ ! -e "$target_dir" ]]; then
```

If the path does not exist, the script exits with an error.

Example:

```text
Error: Path does not exist: does-not-exist
```

This prevents subsequent commands from attempting to operate on an invalid location.

---

## Directory Type Validation

A path may exist but still not be a directory.

The script therefore performs an additional check:

```bash
if [[ ! -d "$target_dir" ]]; then
```

This ensures that the supplied path is actually a directory.

For example, when a file was supplied instead of a directory:

```text
Error: Path is not a directory: automation-output/data/system_info.txt
```

This is an important distinction because checking only whether a path exists would not be sufficient.

---

# 7. Error Handling

The script uses explicit validation and exit codes to handle invalid input.

The general pattern is:

```bash
if [[ condition ]]; then
    echo "Error message"
    exit 1
fi
```

This provides the user with a meaningful error message instead of allowing the script to continue with invalid input.

A non-zero exit status communicates failure to the operating system and to automation systems.

---

# 8. Signal Handling and `trap`

The script uses Bash `trap` to respond to script termination and interruption.

The cleanup handler is registered with:

```bash
trap cleanup EXIT
```

This causes the cleanup function to execute whenever the script exits.

The script also handles interrupt and termination signals:

```bash
trap handle_interrupt INT TERM
```

`INT` represents an interrupt signal, commonly generated when a user presses `Ctrl+C`.

`TERM` represents a termination request.

## Cleanup

The cleanup function is:

```bash
cleanup() {
    echo
    echo "Cleaning up temporary resources..."
}
```

This demonstrates the concept of cleanup handlers.

In a larger automation system, cleanup could be used to:

* Remove temporary files
* Release resources
* Remove temporary directories
* Close connections
* Reset temporary configuration
* Record final execution state

---

# 9. Validation Tests Performed

The safety script was tested using multiple scenarios.

## Test 1 - Valid Directory

Command:

```bash
./scripts/04_safe_automation.sh automation-output
```

Result:

```text
Directory validation successful: automation-output
Temporary file created successfully.
Safe automation completed successfully.
```

The valid input was accepted.

## Test 2 - Missing Argument

Command:

```bash
./scripts/04_safe_automation.sh
```

Result:

```text
Error: A directory path is required.
```

The script correctly rejected missing input.

## Test 3 - Non-existent Path

Command:

```bash
./scripts/04_safe_automation.sh does-not-exist
```

Result:

```text
Error: Path does not exist: does-not-exist
```

The script correctly rejected an invalid path.

## Test 4 - File Supplied Instead of Directory

Command:

```bash
./scripts/04_safe_automation.sh automation-output/data/system_info.txt
```

Result:

```text
Error: Path is not a directory: automation-output/data/system_info.txt
```

The script correctly identified that the supplied path was a file rather than a directory.

---

# 10. Task 5 - Documentation and Repository Organization

The project was organized into dedicated directories for scripts, documentation, screenshots, and generated artifacts.

```text
bash-task-automation/
├── .gitignore
├── COMPLETION_CHECKLIST.md
├── README.md
├── docs/
│   └── project-summary.md
├── screenshots/
└── scripts/
    ├── 01_directory_file_creation.sh
    ├── 02_system_health_monitor.sh
    ├── 03_functions.sh
    ├── 04_safe_automation.sh
    └── lib/
        └── functions.sh
```

The generated `automation-output/` directory is excluded from Git using:

```gitignore
automation-output/
```

This prevents runtime-generated files from being unnecessarily committed to the source repository.

---

# 11. Overall Outcome

All project tasks were implemented and tested successfully.

The project demonstrates foundational DevOps Bash skills including:

* Linux filesystem automation
* Variables
* Command substitution
* Conditional statements
* Functions
* Function arguments
* Local variables
* External function libraries
* Exit codes
* Input validation
* Error handling
* Defensive Bash settings
* Signal handling
* Cleanup using `trap`
* Idempotent automation
* Repository organization
* Technical documentation

The project provides a foundation for more advanced DevOps automation such as CI/CD scripting, infrastructure provisioning, deployment automation, health checks, and operational tooling.

````