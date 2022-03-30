#!/bin/bash

echo " *************** START LOGIN *************** "

  mkdir -p /opt/config_files_backup
  backupfile=$(date +'%Y_%d_%m_%H:%M')
  cp /etc/login.defs /opt/config_files_backup/login.defs-${backupfile}      # login.defsfile backup

  # Set  Expiration Days
  echo
  echo \*\*\*\* Set\ Password\ Expiration\ Days
  egrep -q "^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MAX_DAYS 364\2/" /etc/login.defs || echo "PASS_MAX_DAYS 364" >> /etc/login.defs
  getent passwd | cut -d ':' -f 1 | xargs -n1 chage --maxdays 364

  # Set Password Change Minimum Number of Days
  echo
  echo \*\*\*\* Set\ Password\ Change\ Minimum\ Number\ of\ Days
  egrep -q "^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MIN_DAYS 90\2/" /etc/login.defs || echo "PASS_MIN_DAYS 90" >> /etc/login.defs
  getent passwd | cut -d ':' -f 1 | xargs -n1 chage --mindays 90

  # Set Password Expiring Warning Days
  echo
  echo \*\*\*\* Set\ Password\ Expiring\ Warning\ Days
  egrep -q "^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$/\PASS_WARN_AGE 7\2/" /etc/login.defs || echo "PASS_WARN_AGE 7" >> /etc/login.defs
  getent passwd | cut -d ':' -f 1 | xargs -n1 chage --warndays 7

 echo " *************** END LOGIN *************** "