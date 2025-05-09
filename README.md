# S3 Sync

This shell script helps users sync data from a local directory to an AWS S3 bucket. The script provides a dry-run option, error handling, and logs any errors during the sync process for easier troubleshooting.

## Features

- Syncs data from a local directory to an S3 bucket.
- Option for **dry-run** to preview the sync without making changes.
- Error handling with detailed logs for troubleshooting.
- User confirmation before proceeding with the sync.
- Allows customization of the S3 storage class (currently defaults to `STANDARD`).

## Requirements

- AWS CLI installed and configured with the necessary permissions.
- `bash` shell for executing the script.

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/s3sync.git
   cd s3sync
