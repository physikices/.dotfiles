#!/usr/bin/env bash

echo -e "\033[33m syncing mega-local to mega-rodrigo...\033[0m"
rclone sync -P mega-local mega-rodrigo:
echo -e "\033[32m done!\033[0m"
