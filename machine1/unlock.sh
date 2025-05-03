#!/bin/bash

cat /srv/diskf/keys/machine1/crypto.key | ssh -T root@192.168.1.2 -i /srv/diskf/.ssh/machine1 -p 2222 > /dev/null
