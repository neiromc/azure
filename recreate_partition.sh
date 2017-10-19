#!/bin/bash
#
# Recreate partition to new size
# by Neiro.


LOCKFILE=/azure-script.lock

DISK=$1

if [ ! -f $LOCKFILE ]; then
echo "Part disk..."
### Make changes in partition table
echo "d

n
p


w"| fdisk "$DISK" > /dev/null 2>&1

touch $LOCKFILE

else
 echo "Resize disk..."
 xfs_growfs /dev/sda2 && rm $LOCKFILE
fi

