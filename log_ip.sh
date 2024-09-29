#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(dirname "$0")"

# Load the .env file from the same directory as the script
if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/.env"
else
    echo "Error: .env file not found in $SCRIPT_DIR"
    exit 1
fi

# Function to get the current public IP
get_public_ip() {
    curl -s ifconfig.me || curl -s icanhazip.com
}

# Function to log IP change with plain text
log_plain() {
    local current_ip=$1
    local last_ip=$(cat "$IP_FILE_PATH")

    if [[ "$current_ip" != "$last_ip" ]]; then
        echo "$current_ip" > "$IP_FILE_PATH"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - IP changed from $last_ip to $current_ip" >> "$LOG_FILE_PATH"
    fi
}

# Function to log IP change with encryption
log_encrypted() {
    local current_ip=$1
    local last_ip=$(cat "$IP_FILE_PATH")

    if [[ "$current_ip" != "$last_ip" ]]; then
        echo "$current_ip" > "$IP_FILE_PATH"
        local temp_log=$(mktemp)
        echo "$(date '+%Y-%m-%d %H:%M:%S') - IP changed from $last_ip to $current_ip" > "$temp_log"
        openssl enc -aes-256-cbc -salt -in "$temp_log" -out "$ENCRYPTED_LOG_FILE_PATH" -pass pass:"$ENCRYPTION_PASS"
        rm -f "$temp_log"
    fi
}

# Check for encryption flag
if [[ "$1" == "--encrypt" ]]; then
    current_ip=$(get_public_ip)
    log_encrypted "$current_ip"
else
    current_ip=$(get_public_ip)
    log_plain "$current_ip"
fi
