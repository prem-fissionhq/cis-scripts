#!/bin/sh

echo " *************** START grub *************** "

  mkdir -p /opt/config_files_backup
  backupfile=$(date +'%Y_%d_%m_%H:%M')
  cp /boot/grub2/grub.cfg /opt/config_files_backup/grub.cfg-${backupfile}     # grub.cfg file backup

  # Set User/Group Owner on /boot/grub2/grub.cfg
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ on\ /boot/grub2/grub.cfg
  chown 0:0 /boot/grub2/grub.cfg

  # Set Permissions on /boot/grub2/grub.cfg
  echo
  echo \*\*\*\* Set\ Permissions\ on\ /boot/grub2/grub.cfg
  chmod g-r-w-x,o-r-w-x /boot/grub2/grub.cfg

  # Enable Auditing for Processes That Start Prior to auditd
  echo
  echo \*\*\*\* Enable\ Auditing\ for\ Processes\ That\ Start\ Prior\ to\ auditd
  egrep -q "^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?\"(\s*#.*)?\s*$" /etc/default/grub && sed -ri '/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]*)?\"(\s*#.*)?\s*$/ {/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?audit=\S+(\s+[^\"]+)?\"(\s*#.*)?\s*$/! s/^(\s*GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?)(\"(\s*#.*)?\s*)$/\1 audit=1\3/ }' /etc/default/grub && sed -ri "s/^((\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?)audit=\S+((\s+[^\"]+)?\"(\s*#.*)?\s*)$/\1audit=1\4/" /etc/default/grub || echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >> /etc/default/grub
  grub2-mkconfig -o /boot/grub2/grub.cfg

  #egrep -q "^(\s*)selinux\s*=\s*\S+(\s*#.*)?\s*$" /boot/grub2/grub.cfg && sed -ri "s/^(\s*)selinux\s*=\s*\S+(\s*#.*)?\s*$/\selinux=0\2/" /boot/grub2/grub.cfg || echo "selinux=0" >> /boot/grub2/grub.cfg

echo " *************** END grub *************** "