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

# Function to display help
usage() {
    echo "Usage: $0 [-l] [-e] [-d] [-i input_file] [-o output_file] [-p password] [-h]"
    echo ""
    echo "Options:"
    echo "  -l                 Enable logging mode"
    echo "  -e                 Enable logging with encryption"
    echo "  -d                 Enable decryption mode"
    echo "  -i input_file      Specify input file (for decryption)"
    echo "  -o output_file     Specify output file (for decryption)"
    echo "  -p password        Specify passphrase (for decryption)"
    echo "  -h                 Show this help message"
    exit 1
}

log_mode=false
encrypt_mode=false
decrypt_mode=false
custom_password=""
input_file=""
output_file=""

# Parse command-line arguments
while getopts ":ledp:i:o:h" opt; do
    case $opt in
        l)
            log_mode=true
            ;;
        e)
            log_mode=true
            encrypt_mode=true
            ;;
        d)
            decrypt_mode=true
            ;;
        p)
            custom_password="$OPTARG"
            ;;
        i)
            input_file="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        h)
            usage
            ;;
        *)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Main logic
if [[ "$log_mode" == true ]]; then
    if [[ "$encrypt_mode" == true ]]; then
        "$SCRIPT_DIR/log_ip.sh" --encrypt
    else
        "$SCRIPT_DIR/log_ip.sh" --plain
    fi
elif [[ "$decrypt_mode" == true ]]; then
    "$SCRIPT_DIR/decrypt_log.sh" -i "$input_file" -o "$output_file" -p "$custom_password"
else
    echo "No valid mode selected. Use -l for logging, -e for logging with encryption, or -d for decryption."
    usage
fi
