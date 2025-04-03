#!/bin/bash

orig_iso=$1

orig_iso_mnt=/tmp/debian
custom_files=/tmp/custom_debian

# mount and unpack ISO
mkdir -p "$orig_iso_mnt"
sudo mount -t iso9660 -o loop "$orig_iso" "$orig_iso_mnt"
mkdir -p "$custom_files"
cd "$orig_iso_mnt" && sudo tar cf - . | (cd "$custom_files"; tar xfp -)
sudo chmod 777 -R "$custom_files"
