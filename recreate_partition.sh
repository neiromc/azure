#!/bin/bash
#
# Recreate partition to new size
# by Neiro.


SERVICE_NAME=azure-deploy
SERVICE_PATH=/etc/systemd/system/

LOCKFILE=/${SERVICE_NAME}.lock


DISK=$1

if [ ! -f $LOCKFILE ]; then
echo "Part disk..."
### Make changes in partition table
echo "d

n
p


w"| fdisk "$DISK" > /dev/null 2>&1

touch $LOCKFILE

echo "
[Unit]
Description=3adigital Resize XFS
After=network-online.target

[Service]
Type=oneshot
ExecStart=/var/lib/waagent/custom-script/download/0/recreate_partition.sh
RemainAfterExit=yes
User=root
Group=root

[Install]
WantedBy=multi-user.target
" > ${SERVICE_PATH}/${SERVICE_NAME}.service

systemctl daemon-reload
systemctl enable $SERVICE_NAME

else
 echo "Resize disk..."
 xfs_growfs /dev/sda2 && systemctl disable $SERVICE_NAME && rm $LOCKFILE ${SERVICE_PATH}/${SERVICE_NAME}.service && systemctl daemon-reload
fi

