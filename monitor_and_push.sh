#!/bin/bash

# Load configuration
source config.cfg

# Function to calculate checksum
calculate_checksum() {
    find "$MONITOR_PATH" -type f -exec sha256sum {} + | sha256sum | awk '{print $1}'
}

# Initial checksum
prev_checksum=$(calculate_checksum)

echo "Monitoring changes in: $MONITOR_PATH"

while true; do
    sleep 10  # Check interval
    current_checksum=$(calculate_checksum)
    
    if [[ "$prev_checksum" != "$current_checksum" ]]; then
        echo "Changes detected!"
        cd "$REPO_PATH" || exit
        
        # Stage changes
        git add "$MONITOR_PATH"
        
        # Commit changes
        commit_message="Auto-commit: Changes detected in $MONITOR_PATH"
        git commit -m "$commit_message"
        
        # Push changes
        if git push "$GIT_REMOTE" "$GIT_BRANCH"; then
            echo "Changes pushed successfully."
            send_notification "$commit_message"
        else
            echo "Git push failed!"
        fi
        
        # Update checksum
        prev_checksum=$current_checksum
    fi

done

# Function to send email notification
send_notification() {
    local message=$1
    curl --request POST \
      --url https://sandbox.smtp.mailtrap.io/api/send \
      --header "Authorization: Bearer $MAILTRAP_API_KEY" \
      --header "Content-Type: application/json" \
      --data '{
        "from": {"email": "'$SENDER_EMAIL'"},
        "to": ['$(printf '{"email": "%s"},' ${COLLABORATORS[@]} | sed 's/,$//')'],
        "subject": "Repository Update Notification",
        "text": "'$message'"
      }'
}
