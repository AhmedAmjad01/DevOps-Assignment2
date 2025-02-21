# DevOps-Assignment2
# Automated Git Monitoring and Notification Script

## Overview
This Bash script monitors a specified directory or file for changes, automatically commits and pushes updates to a Git repository, and sends an email notification via Mailtrap when changes are detected.

## Prerequisites
Before running the script, ensure you have the following installed and configured:

1. **Git** - Ensure Git is installed and configured:
   ```bash
   git --version
   ```
2. **Mailtrap API Key** - Create an account on [Mailtrap](https://mailtrap.io/) and obtain an API key for sending email notifications.
3. **Bash Shell** - Ensure you are running the script in a Unix-based environment (Linux, macOS, or Git Bash on Windows).

## Setup Instructions
### 1. Clone the Repository
```bash
git clone 
cd YourRepo
```

### 2. Configure the Script
Edit the `config.cfg` file to specify your repository details and email settings:

```ini
# Configuration file
REPO_PATH="/path/to/your/repo"
MONITOR_PATH="/path/to/monitor"
GIT_REMOTE="origin"
GIT_BRANCH="main"
COLLABORATORS=("email1@example.com" "email2@example.com")
MAILTRAP_API_KEY="your_mailtrap_api_key"
SENDER_EMAIL="your_sender_email@example.com"
```

### 3. Run the Script
Give the script execution permissions and start monitoring:
```bash
chmod +x monitor_and_push.sh
./monitor_and_push.sh
```

## Example Usage
1. **Modify a file in the monitored directory**
2. The script detects the change, commits, and pushes it:
   ```bash
   Auto-commit: Changes detected in /path/to/monitor
   Changes pushed successfully.
   ```
3. An email notification is sent to the configured recipients.

## Troubleshooting
- If Git push fails, ensure you have the latest changes:
  ```bash
  git pull origin main --rebase
  ```
- If the script does not detect changes, verify that `MONITOR_PATH` is set correctly.

## License
This project is open-source and available for modification and use.

