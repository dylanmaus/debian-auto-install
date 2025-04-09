#!/bin/bash

cat crypto.key | ssh -T root@192.168.1.3 -i ~/.ssh/machine0 -p 2222 > /dev/null
