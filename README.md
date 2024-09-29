# IP Monitor Script

This script monitors your public IP address, logs any changes, and supports both plain text and encrypted logging. It can also decrypt the encrypted log for viewing later.

## Usage

You will need to clone this repository 

```bash
git clone https://github.com/MohamedElashri/ip-monitor
cd ip-monitor
```

### Logging IP Address Changes
To start monitoring and logging IP address changes, use the following commands:

- **Plain Logging:**
  ```bash
  ./ip_monitor.sh -l
  ```

- **Encrypted Logging:**
  ```bash
  ./ip_monitor.sh.sh -e
  ```

### Decrypt the Encrypted Log
To decrypt the encrypted log file:

- Use the default input and output paths from `.env`:
  ```bash
  ./ip_monitor.sh.sh -d
  ```

- Specify custom input and output paths:
  ```bash
  ./ip_monitor.sh.sh -d -i /custom/path/to/encrypted.log -o /custom/path/to/decrypted.log
  ```

- Use a custom passphrase:
  ```bash
  ./ip_monitor.sh.sh -d -p "your-custom-passphrase"
  ```

### Environment Configuration

The paths, email credentials, and encryption settings are all stored in the `.env` file. Modify the file to suit your environment:

```bash
# Email settings for notifications
SMTP_HOST="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="your-email@example.com"
SMTP_PASS="your-email-password"
RECIPIENT_EMAIL="recipient@example.com"

# Encryption passphrase (uncomment if encryption is needed)
# ENCRYPTION_PASS="your-encryption-passphrase"

# Paths for log files
IP_FILE_PATH="./ip_address.txt"
LOG_FILE_PATH="./plain_ip_log.txt"
ENCRYPTED_LOG_FILE_PATH="./encrypted_ip_log.enc"
DECRYPTED_LOG_FILE_PATH="./decrypted_ip_log.txt"
```

### Options

- `-l`: Enable plain logging.
- `-e`: Enable encrypted logging.
- `-d`: Enable decryption mode.
- `-i input_file`: Specify the input file for decryption.
- `-o output_file`: Specify the output file for decryption.
- `-p password`: Specify the passphrase for encryption/decryption.
- `-h`: Show help message.

### Examples

- **Plain Logging Mode:**
  ```bash
  ./monitor_ip.sh -l
  ```
  This will monitor your public IP address and log any changes to a plain text file at the location specified in `LOG_FILE_PATH` in the `.env` file.

- **Encrypted Logging Mode:**
  ```bash
  ./ip_monitor.sh.sh -e
  ```
  This will log IP changes, but the logs will be encrypted using the AES-256-CBC algorithm. The encrypted log will be saved to the location specified in `ENCRYPTED_LOG_FILE_PATH`.

- **Decrypt the Encrypted Log:**
  ```bash
  ./ip_monitor.sh.sh -d
  ```
  This will decrypt the encrypted log using the default paths specified in the `.env` file and save the result to the `DECRYPTED_LOG_FILE_PATH`. 

  To specify a custom input or output file:
  ```bash
  ./ip_monitor.sh -d -i /custom/path/encrypted.log -o /custom/path/decrypted.log
  ```

  To specify a custom decryption passphrase:
  ```bash
  ./ip_monitor.sh.sh -d -p "custom-passphrase"
  ```

### Customizing the Script

You can customize the behavior of the script by editing the `.env` file. For example:

- Change the location where IP logs are stored (plain or encrypted).
- Modify the email settings to receive notifications of IP changes.
- Update the encryption passphrase for better security.

```bash
# Example content for .env:

# Email settings for notifications
SMTP_HOST="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="your-email@example.com"
SMTP_PASS="your-email-password"
RECIPIENT_EMAIL="recipient@example.com"

# Encryption passphrase for logs (uncomment if using encryption)
# ENCRYPTION_PASS="your-encryption-passphrase"

# File paths for storing logs and IP addresses
IP_FILE_PATH="./ip_address.txt"
LOG_FILE_PATH="./plain_ip_log.txt"
ENCRYPTED_LOG_FILE_PATH="./encrypted_ip_log.enc"
DECRYPTED_LOG_FILE_PATH="./decrypted_ip_log.txt"
```

### Notes

- Make sure that the OpenSSL command-line tool is installed on your system. If it’s not installed, you can install it using your package manager:
  - On Debian/Ubuntu:
    ```bash
    sudo apt install openssl
    ```
  - On CentOS/RHEL:
    ```bash
    sudo yum install openssl
    ```

- Ensure that your email configuration is correct to receive notifications.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request for any improvements or feature requests.
