#!/usr/bin/env bash

echo -e "\033[33m syncing physikices-local to gdrive-physikices...\033[0m"
rclone sync -P physikices-local gdrive-physikices:
echo -e "\033[32m done!\033[0m"
