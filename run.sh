#!/bin/bash

# get variables from config file
. $1

# get user password from input
read -s -p "Enter user password: " user_password

# create files containing generated keys
root_password=`openssl rand -base64 48`
echo -n "$root_password" > ./"$name"/root.key

# download Debian ISO if it doesn't exist already
if [ ! -f "$orig_iso" ]; then
   wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/"$orig_iso"
fi

# populate preseed.cfg
cp default-preseed.cfg "$name"/preseed.cfg
./populate-preseed.sh $1 "$user_password" "$root_password"

# copy files to tmphost to serve during install
cp ./"$name"/preseed.cfg ./tmphost

# mount and unpack ISO to modifiable location
./mount-unpack-iso.sh "$orig_iso"

# modify grub.cfg to auto install with preseed
./modify-grub.sh "$url" "$network_interface"

# repack bootable ISO
./repack-bootable-iso.sh "$orig_iso" "$name"/"$new_iso"

# unmount and delete temporary files
orig_iso_mnt=/tmp/debian
custom_files=/tmp/custom_debian
mbr_template=isohdpfx.bin
sudo umount "$orig_iso_mnt"
sudo rm -r "$orig_iso_mnt"
sudo rm -r "$custom_files"
rm "$mbr_template"
