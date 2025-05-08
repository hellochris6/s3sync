#!/bin/bash

# Author: Chris Blue   
# Date: 2024-09-03
# Purpose: This script will sync data from a local directory to an S3 bucket.

# Tell user what this script does and confirm they want to run it
echo "This script will sync your data from a local directory to an S3 bucket."
read -p "Do you want to continue? Type Y or N: " choice_continue

# If user selects Y, proceed with the synchronization
if [ "$choice_continue" == "Y" ]; then

    # Prompt user for sync details
    read -p "Enter the path to the local source directory: " SRC_DIR
    read -p "Enter the S3 URI of the bucket destination (e.g., s3://bucket-name/destination-path): " DEST_DIR

    # Ask if the user wants to perform a dry run
    read -p "Would you like to perform a dry run first? (Y/N): " dryRunChoice

    # Set dry run option based on user input
    if [ "$dryRunChoice" == "Y" ]; then
        dryRunOption="--dryrun"
    else
        dryRunOption=""
    fi

    # Confirm sync settings with user
    echo "
Please confirm the following sync settings:
Source: $SRC_DIR
Destination: $DEST_DIR
Dry run: ${dryRunOption:-No}
Type CONFIRM to continue or anything else to exit."
    read confirm_sync

    if [ "$confirm_sync" != "CONFIRM" ]; then
        echo "Sync operation not confirmed. Exiting."
        exit 1
    fi

    # Execute the sync command and log errors
    echo "Starting sync operation..."
    sync_command="aws s3 sync \"$SRC_DIR\" \"$DEST_DIR\" --storage-class STANDARD $dryRunOption"
    ERR_LOG=~/Documents/aws-sync-error-log
    eval $sync_command 2>> "$ERR_LOG"

    # Provide a summary of the sync operation with enhanced error handling
    if [ $? -eq 0 ]; then
        echo "Sync operation completed successfully."
    elif [ $? -eq 1 ]; then
        echo "Sync operation failed due to a general error. Check the error log at $ERR_LOG for details."
    elif [ $? -eq 2 ]; then
        echo "Sync operation failed due to network issues. Please check your connection and try again."
    elif [ $? -eq 3 ]; then
        echo "Sync operation failed due to permission issues. Please ensure you have the correct permissions."
    else
        echo "Sync operation failed with an unknown error. Check the error log at $ERR_LOG for details."
    fi

else
    echo "You did not type Y. Closing script."
fi