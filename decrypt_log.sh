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

# Default variables
input_file="$ENCRYPTED_LOG_FILE_PATH"
output_file="$DECRYPTED_LOG_FILE_PATH"
password="$ENCRYPTION_PASS"

# Parse arguments
while getopts ":i:o:p:h" opt; do
    case $opt in
        i)
            input_file="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        p)
            password="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-i input_file] [-o output_file] [-p password] [-h]"
            exit 1
            ;;
        *)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Decrypt the log
if [[ -f "$input_file" ]]; then
    openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -pass pass:"$password"
    if [[ $? -eq 0 ]]; then
        echo "Decryption successful. Output saved to $output_file."
    else
        echo "Decryption failed."
    fi
else
    echo "Error: Encrypted file not found!"
fi
