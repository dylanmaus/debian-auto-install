#!/bin/bash

cat /srv/diskf/keys/machine2/crypto.key | ssh -T root@192.168.1.6 -i ~/.ssh/machine2 -p 2222 > /dev/null
