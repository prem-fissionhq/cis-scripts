#!/bin/bash
 
echo " *************** START NTP *************** "

  mkdir -p /opt/config_files_backup
  cp /etc/ntp.conf /opt/config_files_backup/ntp.conf-backup             # ntp.conf file backup
  cp /etc/sysconfig/ntpd /opt/config_files_backup/ntpd-backup           # ntpd file backup

  # Configure Network Time Protocol (NTP)
  a=$(cat /etc/ntp.conf | grep 'restrict default kod nomodify notrap nopeer noquery')
  c='restrict default kod nomodify notrap nopeer noquery'
  if [ "$a" != "$c" ]
  then
          echo 'restrict default kod nomodify notrap nopeer noquery' >> /etc/ntp.conf
          echo "Updated 1"
  elif [ "$a" == "$c" ]
  then
           echo "Change already present 1"
  fi

  a=$(cat /etc/ntp.conf | grep 'restrict -6 default kod nomodify notrap nopeer noquery')
  c='restrict -6 default kod nomodify notrap nopeer noquery'
  if [ "$a" != "$c" ]
  then
          echo 'restrict -6 default kod nomodify notrap nopeer noquery' >> /etc/ntp.conf
          echo "Updated 2"
  elif [ "$a" == "$c" ]
  then
           echo "Change already present 2"
  fi

  # Configure Network Time Protocol (NTP)
  a=$(cat /etc/sysconfig/ntpd | grep 'OPTIONS="-u ntp:ntp"')
  c='OPTIONS="-u ntp:ntp"' 
  if [ "$a" != "$c" ]
  then
          echo 'OPTIONS="-u ntp:ntp"' >> /etc/sysconfig/ntpd
          echo "Updated 3"
  elif [ "$a" == "$c" ]
  then
          echo "Change already present 3"
  fi
echo " *************** END NTP *************** "