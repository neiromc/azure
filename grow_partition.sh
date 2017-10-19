#!/bin/bash
#
# Grow partition to new size
# by Neiro.

DISK=$1


###
xfs_growfs $DISK