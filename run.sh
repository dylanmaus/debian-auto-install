#!/bin/bash

# get variables from config file
. $1

# get user password from input
read -p "Enter user password: " user_password

echo "$user_password"

# create dir for files
mkdir -p "$name"

# create files containing generated keys
crypto_password=`openssl rand -base64 32 | sed -r 's/[/=]/_/g'`
root_password=`openssl rand -base64 32 | sed -r 's/[/=]/_/g'`
echo -n "$crypto_password" > ./"$name"/crypto.key
echo -n "$root_password" > ./"$name"/root.key

# download Debian ISO if it doesn't exist already
if [ ! -f "$orig_iso" ]; then
   wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/"$orig_iso"
fi

# mount and unpack ISO to modifiable location
./mount_unpack_iso.sh "$orig_iso"

# modify grub.cfg to auto install with preseed
./modify_grub.sh "$preseed_url" "$network_interface"

# repack bootable ISO
./repack_bootable_iso.sh "$orig_iso" "$name"/"$new_iso"

# populate preseed.cfg
cp default-preseed.cfg "$name"/custom-preseed.cfg
./populate-preseed.sh $1 "$user_password" "$root_password" "$crypto_password"

# unmount and delete temporary files
orig_iso_mnt=/tmp/debian
custom_files=/tmp/custom_debian
mbr_template=isohdpfx.bin
sudo umount "$orig_iso_mnt"
sudo rm -r "$orig_iso_mnt"
sudo rm -r "$custom_files"
rm "$mbr_template"
