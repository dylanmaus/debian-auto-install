#!/bin/bash

working_dir=`pwd`
orig_iso=debian-12.10.0-amd64-netinst.iso
orig_iso_mnt=/tmp/debian
custom_files=/tmp/custom_debian
new_iso=preseed-$orig_iso
mbr_template=isohdpfx.bin
preseed_url=http://192.168.1.7:8000/preseed/preseed.cfg

# download Debian ISO if it doesn't exist already
if [ ! -f $orig_iso ]; then
   wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$orig_iso
fi

# mount and unpack ISO
mkdir -p $orig_iso_mnt
sudo mount -t iso9660 -o loop $orig_iso $orig_iso_mnt
mkdir -p $custom_files
cd $orig_iso_mnt && sudo tar cf - . | (cd $custom_files; tar xfp -)
sudo chmod 777 -R $custom_files

# modify grub.cfg to auto install with preseed 
old_line="linux    /install.amd/vmlinuz vga=788 --- quiet"
new_line="linux    /install.amd/vmlinuz preseed/url=$preseed_url auto=true priority=critical vga=788 --- quiet"
sed -i s"|$old_line|$new_line|g" $custom_files/boot/grub/grub.cfg
echo "set timeout=2" >> $custom_files/boot/grub/grub.cfg

cd $working_dir

# extract MBR template file to disk
dd if=$orig_iso bs=1 count=432 of=$mbr_template

# create new ISO image
xorriso -as mkisofs \
   -r -V 'Debian 12.10.0 amd64 n' \
   -o $new_iso \
   -J -J -joliet-long -cache-inodes \
   -isohybrid-mbr $mbr_template \
   -b isolinux/isolinux.bin \
   -c isolinux/boot.cat \
   -boot-load-size 4 -boot-info-table -no-emul-boot \
   -eltorito-alt-boot \
   -e boot/grub/efi.img \
   -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus \
   $custom_files

# unmount and delete temporary files
sudo umount $orig_iso_mnt
sudo rm -r $orig_iso_mnt
sudo rm -r $custom_files
