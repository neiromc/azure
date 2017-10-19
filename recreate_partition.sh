#!/bin/bash
#
# Recreate partition to new size
# by Neiro.


SERVICE_NAME=azure-deploy
SERVICE_PATH=/etc/systemd/system/

LOCKFILE=/${SERVICE_NAME}.lock
LOG=/${SERVICE_NAME}.log

DISK=/dev/sda

if [ ! -f $LOCKFILE ]; then
echo "Part disk..." >> $LOG
### Make changes in partition table
echo "p
d

n
p



p
w"| fdisk "$DISK"  >> $LOG
#> /dev/null 2>&1

echo "----- END OF FDISK -------"

touch $LOCKFILE

echo "
[Unit]
Description=Resize XFS Once
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

shutdown +1 -r & >> $LOG

echo "Reboot scheduled..." >> $LOG

exit 0

else
 echo "Resize disk..." >> $LOG
 xfs_growfs /dev/sda2 >> $LOG
 
 systemctl disable $SERVICE_NAME && rm $LOCKFILE ${SERVICE_PATH}/${SERVICE_NAME}.service && systemctl daemon-reload

 echo "Done!" >> $LOG
fi

