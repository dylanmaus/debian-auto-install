#!/bin/bash

cat crypto.key | ssh -T root@192.168.1.2 -i /srv/diskf/.ssh/machine1 -p 2222 > /dev/null
