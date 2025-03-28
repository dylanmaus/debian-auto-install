#!/bin/bash

username=user

# add user to sudoers
adduser "$username" sudo

# configure dropbear
apt update
apt install -y dropbear-initramfs
echo 'DROPBEAR_OPTIONS="-I 180 -j -k -p 2222 -s -c cryptroot-unlock"' >> /etc/dropbear/initramfs/dropbear.conf

# add ssh public key to authorized keys
echo ssh-ed25519 asdfzxcv user@machine > /etc/dropbear/initramfs/authorized_keys

echo 'IP="dhcp"' >> /etc/initramfs-tools/initramfs.conf
update-initramfs -u -k all
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet ip=dhcp"/g' /etc/default/grub
update-grub
