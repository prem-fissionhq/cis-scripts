#!/bin/bash
 
echo " *************** START COREDUMP *************** "

mkdir -p /opt/config_files_backup
backupfile=$(date +'%Y_%d_%m_%H:%M')
cp /etc/systemd/coredump.conf opt/config_files_backup/coredump.conf-${backupfile}       # coredump.conf file backup

egrep -q "^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/coredump.conf && sed -ri "s/^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$/\Storage=none\2/" /etc/systemd/coredump.conf || echo "Storage=none" >> /etc/systemd/coredump.conf
egrep -q "^(\s*)ProcessSizeMax\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/coredump.conf && sed -ri "s/^(\s*)ProcessSizeMax\s*=\s*\S+(\s*#.*)?\s*$/\ProcessSizeMax=0\2/" /etc/systemd/coredump.conf || echo "ProcessSizeMax=0" >> /etc/systemd/coredump.conf

echo " *************** END COREDUMP *************** "