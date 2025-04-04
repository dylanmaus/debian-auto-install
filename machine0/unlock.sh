#!/bin/bash

# cat ./crypto.key | ssh -tt root@192.168.1.3 -i ~/.ssh/machine0.pub -p 2222 > /dev/null
cat crypto.key | ssh -vvvv -tt root@192.168.1.3 -o HostKeyAlgorithms=ssh-ed25519 -i ~/.ssh/machine0.pub -p 2222 > /dev/null
# cat crypto.key | ssh -vvvv -tt root@192.168.1.3 -o "HostKeyAlgorithms ssh-ed25519" IdentitiesOnly=yes -i ~/.ssh/machine0.pub -p 2222 > /dev/null
# cat "tmp.txt" | ssh -tt root@192.168.1.5 -i ~/.ssh/machine3.pub -p 2222 2> /dev/null
# ssh user@machine3
