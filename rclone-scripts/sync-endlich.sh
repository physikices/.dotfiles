#!/usr/bin/env bash

echo -e "\033[33m syncing endlich-local to gdrive-endlich...\033[0m"
rclone sync -P endlich-local gdrive-endlich:
echo -e "\033[32m done!\033[0m"

