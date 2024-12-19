#!/usr/bin/env bash

echo -e "\033[33m syncing proton-local to proton-physikices...\033[0m"
rclone sync -P proton-local proton-physikices:
echo -e "\033[32m done!\033[0m"
