#!/bin/bash

preseed_name=machine
user=username
user_password=userpassword
root_password=rootpassword
crypto_password=`openssl rand -base64 32 | sed -r 's/[/=]/_/g'`
disk=/dev/nvme1n1
post_preseed_url=http://192.168.1.7:8000/post_preseed.sh

cp default_preseed.cfg  "$preseed_name"-pressed.cfg

# populate user info
old="d-i passwd/user-fullname string user"
new="d-i passwd/user-fullname string "$user""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

old="d-i passwd/username string user"
new="d-i passwd/username string "$user""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

old="d-i passwd/user-password password userpassword"
new="d-i passwd/user-password password "$user_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

old="d-i passwd/user-password-again password userpassword"
new="d-i passwd/user-password-again password "$user_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

# populate root info
old="d-i passwd/root-password password rootpassword"
new="d-i passwd/root-password password "$root_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

old="d-i passwd/root-password-again password rootpassword"
new="d-i passwd/root-password-again password "$root_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

# populate disk
old="d-i partman-auto/disk string /dev/sda"
new="d-i partman-auto/disk string "$disk""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

# populate crypto password
old="d-i partman-crypto/passphrase string cryptopassword"
new="d-i partman-crypto/passphrase string "$crypto_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

old="d-i partman-crypto/passphrase-again string cryptopassword"
new="d-i partman-crypto/passphrase-again string "$crypto_password""
sed -i s"|$old|$new|g" "$preseed_name"-pressed.cfg

# populate post preseed url
sed -i s"|url|$post_preseed_url|g" "$preseed_name"-pressed.cfg
