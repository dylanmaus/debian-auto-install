#!/bin/bash

. $1
user_password=$2
root_password=$3
crypto_password=$4

# populate user info
sed -i s"|defaultusername|$username|g" "$name"/custom-preseed.cfg
sed -i s"|defaultuserpassword|$user_password|g" "$name"/custom-preseed.cfg

# populate root password
sed -i s"|defaultrootpassword|$root_password|g" ./"$name"/custom-preseed.cfg

# populate disk
sed -i s"|defaultdisk|$disk|g" "$name"/custom-preseed.cfg

# populate crypto password
sed -i s"|defaultcryptopassword|$crypto_password|g" "$name"/custom-preseed.cfg

# populate post preseed url
sed -i s"|defaulturl|$preseed_url|g" "$name"/custom-preseed.cfg
