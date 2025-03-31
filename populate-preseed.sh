#!/bin/bash

preseed_name=machine0
filename=machine0-preseed.cfg
username=user
userpassword=userpassword
rootpassword=rootpassword
cryptopassword=`openssl rand -base64 32 | sed -r 's/[/=]/_/g'`
disk=/dev/sda
post_preseed_url=http://192.168.1.7:8000/post_preseed.sh

. $1

echo -n "$cryptopassword" > "$preseed_name"

cp default-preseed.cfg "$filename"

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
