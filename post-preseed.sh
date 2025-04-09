#!/bin/bash

. $1

adduser "$username" sudo

# configure dropbear
apt update
apt install -y dropbear-initramfs
echo 'DROPBEAR_OPTIONS="-RFEsjk -p 2222 -s -c cryptroot-unlock"' >> /etc/dropbear/initramfs/dropbear.conf

# add ssh public key to authorized keys
echo "$ssh_public_key" > /etc/dropbear/initramfs/authorized_keys

chmod 600 /etc/dropbear/initramfs/authorized_keys
chown root:root /etc/dropbear/initramfs/authorized_keys

echo 'IP="dhcp"' >> /etc/initramfs-tools/initramfs.conf
update-initramfs -u -k all
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet ip=dhcp"/g' /etc/default/grub
update-grub
