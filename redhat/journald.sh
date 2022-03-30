#!/bin/bash

echo " *************** START JOURNALD *************** "

mkdir -p /opt/config_files_backup
backupfile=$(date +'%Y_%d_%m_%H:%M')
cp /etc/systemd/journald.conf /opt/config_files_backup/journald.conf-${backupfile}      # journald.conf file backup

egrep -q "^(\s*)ForwardToSyslog\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)ForwardToSyslog\s*=\s*\S+(\s*#.*)?\s*$/\1ForwardToSyslog=yes\2/" /etc/systemd/journald.conf || echo "ForwardToSyslog=yes" >> /etc/systemd/journald.conf
egrep -q "^(\s*)Compress\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)Compress\s*=\s*\S+(\s*#.*)?\s*$/\1Compress=yes\2/" /etc/systemd/journald.conf || echo "Compress=yes" >> /etc/systemd/journald.conf
egrep -q "^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$/\1Storage=persistent\2/" /etc/systemd/journald.conf || echo "Storage=persistent" >> /etc/systemd/journald.conf

echo " *************** END JOURNALD *************** "