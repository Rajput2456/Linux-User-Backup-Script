#!/bin/bash

log_file="/home/rajput-stuti/user-backup-project/backup.log"

while true; do
    echo "-------------------------------------------"
    echo " Welcome to User Management & Backup Script "
    echo "-------------------------------------------"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. List Users"
    echo "4. Backup /home Directory"
    echo "5. Exit"
    echo "-------------------------------------------"
    read -p "Choose an option [1-5]: " choice

    case $choice in
        1)
            read -p "Enter username to add: " username
            sudo adduser "$username"
            ;;
        2)
            read -p "Enter username to delete: " username
            sudo deluser "$username"
            ;;
        3)
            echo "Listing all users:"
            cut -d: -f1 /etc/passwd
            ;;
        4)
            timestamp=$(date +%Y%m%d_%H%M%S)
            backup_file="/home/rajput-stuti/user-backup-project/home_backup_$timestamp.tar.gz"

            echo "[$(date)] Starting backup..." >> "$log_file"
            tar -czf "$backup_file" /home 2>> "$log_file"

            if [[ $? -eq 0 ]]; then
                echo "[$(date)] Backup successful: $backup_file" >> "$log_file"
                echo "[$(date)] Size: $(du -sh "$backup_file" | cut -f1)" >> "$log_file"
                echo "Backup saved as $(basename "$backup_file")"
            else
                echo "[$(date)] Backup failed." >> "$log_file"
                echo "Backup failed!"
            fi
            ;;
        5)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1-5."
            ;;
    esac
done
