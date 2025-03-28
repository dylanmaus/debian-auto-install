#!/bin/bash

user=zxcv
user_password=userpassword
root_password=rootpassword
crypto_password=cryptopassword
disk=/dev/nvme1n1
post_preseed_url=http://192.168.1.7:8000/post_preseed.sh

sed -i 's/d-i passwd/user-fullname string/d-i passwd/user-fullname string $user/g' ./preseed.cfg
sed -i 's/d-i passwd/username string/d-i passwd/username string $user/g' ./preseed.cfg
# sed -i s"|d-i passwd/user-fullname string user|d-i passwd/user-fullname string $user|g" ./preseed.cfg
