#!/bin/bash

orig_iso=$1
new_iso=$2

mbr_template=isohdpfx.bin
custom_files=/tmp/custom_debian

# extract MBR template file to disk
dd if="$orig_iso" bs=1 count=432 of="$mbr_template"

# create new ISO image
xorriso -as mkisofs \
   -r -V 'Debian 12.10.0 amd64 n' \
   -o "$new_iso" \
   -J -J -joliet-long -cache-inodes \
   -isohybrid-mbr "$mbr_template" \
   -b isolinux/isolinux.bin \
   -c isolinux/boot.cat \
   -boot-load-size 4 -boot-info-table -no-emul-boot \
   -eltorito-alt-boot \
   -e boot/grub/efi.img \
   -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus \
   "$custom_files"
