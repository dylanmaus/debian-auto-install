#!/bin/bash

url=$1
network_interface=$2

custom_files=/tmp/custom_debian

# modify grub.cfg to auto install with preseed and set network interface
old_line="linux    /install.amd/vmlinuz vga=788 --- quiet"
new_line="linux    /install.amd/vmlinuz preseed/url="$url"/preseed.cfg interface="$network_interface" auto=true priority=critical vga=788 --- quiet"
sed -i s"|$old_line|$new_line|g" "$custom_files"/boot/grub/grub.cfg
echo "set timeout=2" >> "$custom_files"/boot/grub/grub.cfg
