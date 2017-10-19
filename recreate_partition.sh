#!/bin/bash
#
# Recreate partition to new size
# by Neiro.

DISK=$1

### Make changes in partition table
echo "d

n
p


w"| fdisk "$DISK" > /dev/null 2>&1


exit 0

###
#reboot

###
#xfs_growfs /dev/sda2
