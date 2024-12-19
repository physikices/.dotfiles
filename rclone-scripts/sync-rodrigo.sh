#!/usr/bin/env bash

echo -e "\033[33m syncing rodrigo-local to gdrive-rodrigo...\033[0m"
rclone sync -P rodrigo-local gdrive-rodrigo:
echo -e "\033[32m done!\033[0m"
