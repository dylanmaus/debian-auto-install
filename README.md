# Debian auto install
Debian auto install with full disk encryption

## Quick setup
Auto install on system `machine`
```
mkdir tmphost
mkdir machine
touch machine/machine.conf
bash run.sh machine/machine.conf
```

## Create custom ISO
1. download Debian ISO
2. mount and unpack
3. add preseed URL and network interface to `/boot/grub/grub.cfg`
4. repack bootable ISO

```
bash create-custom-iso.sh
```

## Populate preseed
```
bash populate_preseed.sh
```

## Serve preseed on network
```
python3 -m http.server 8000
```

## Write ISO to a drive
```
lsblk
sudo dd if=preseed-debian-12.10.0-amd64-netinst.iso of=/dev/sdX
```

## Host files
```
cd tmphost
python3 -m http.server 8000
```

## Helpful links
https://wiki.debian.org/RepackBootableISO
