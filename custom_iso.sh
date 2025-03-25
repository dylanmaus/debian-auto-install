#!/bin/bash

# https://wiki.debian.org/RepackBootableISO
working_dir=`pwd`
echo $working_dir
orig_iso=debian-12.10.0-amd64-netinst.iso
orig_iso_mnt=/tmp/debian
custom_files=/tmp/custom_debian
new_iso=preseed-$orig_iso
mbr_template=isohdpfx.bin

# download Debian ISO if it doesn't exist already
if [ ! -f $orig_iso ]; then
   wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$orig_iso
fi

# mount and unpack ISO
mkdir -p $orig_iso_mnt
sudo mount -o loop $orig_iso $orig_iso_mnt
mkdir -p $custom_files
cd $orig_iso_mnt && sudo tar cf - . | (cd $custom_files; tar xfp -)

cd $working_dir

# Extract MBR template file to disk
dd if="$orig_iso" bs=1 count=432 of="$mbr_template"

# Create the new ISO image
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
