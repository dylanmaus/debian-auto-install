#!/bin/bash

preseed_name=machine
filename="$preseed_name"-preseed.cfg
username=username
userpassword=userpassword
rootpassword=rootpassword
cryptopassword=`openssl rand -base64 32 | sed -r 's/[/=]/_/g'`
disk=/dev/nvme1n1
url=http://192.168.1.7:8000/post_preseed.sh

cp default_preseed.cfg "$filename"

# populate user info
sed -i s"|defaultusername|$username|g" "$filename"
sed -i s"|defaultuserpassword|$userpassword|g" "$filename"

# populate root password
sed -i s"|defaultrootpassword|$rootpassword|g" "$filename"

# populate disk
sed -i s"|defaultdisk|$disk|g" "$filename"

# populate crypto password
sed -i s"|defaultcryptopassword|$cryptopassword|g" "$filename"

# populate post preseed url
sed -i s"|defaulturl|$url|g" "$filename"
