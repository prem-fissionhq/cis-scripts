#!/bin/bash

echo " *************** START PWQUALITY *************** "

  mkdir -p /opt/config_files_backup
  backupfile=$(date +'%Y_%d_%m_%H:%M')
  cp /etc/bashrc /opt/config_files_backup/bashrc-${backupfile}                       # bashrc file backup
  cp /etc/security/pwquality.conf /opt/config_files_backup/pwquality.conf-${backupfile}  # pwquality.conf file backup
  cp /etc/profile /opt/config_files_backup/profile-${backupfile}                     # profile file backup
  cp /etc/selinux/config /opt/config_files_backup/selinux-config-${backupfile}       # selinux-config file backup
  cp /etc/pam.d/system-auth /opt/config_files_backup/system-auth-${backupfile}       # system-auth file backup
  cp /etc/pam.d/su /opt/config_files_backup/pam.d-su-${backupfile}                   # pam.d-su file backup
  cp /etc/profile.d/cis.sh /opt/config_files_backup/profile-cis-${backupfile}        # profile-cis file backup

 # Set Password Creation Requirement Parameters Using pam_pwquality
  echo
  echo \*\*\*\* Set\ Password\ Creation\ Requirement\ Parameters\ Using\ pam_pwquality
  egrep -q "^(\s*)minlen\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)minlen\s*=\s*\S+(\s*#.*)?\s*$/\minlen=14\2/" /etc/security/pwquality.conf || echo "minlen=14" >> /etc/security/pwquality.conf
  egrep -q "^(\s*)minclass\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)minclass\s*=\s*\S+(\s*#.*)?\s*$/\minclass=4\2/" /etc/security/pwquality.conf || echo "minclass=4" >> /etc/security/pwquality.conf

  egrep -q "^(\s*)dcredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)dcredit\s*=\s*\S+(\s*#.*)?\s*$/\dcredit=-1\2/" /etc/security/pwquality.conf || echo "dcredit=-1" >> /etc/security/pwquality.conf
  egrep -q "^(\s*)ucredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)ucredit\s*=\s*\S+(\s*#.*)?\s*$/\ucredit=-1\2/" /etc/security/pwquality.conf || echo "ucredit=-1" >> /etc/security/pwquality.conf
  egrep -q "^(\s*)ocredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)ocredit\s*=\s*\S+(\s*#.*)?\s*$/\ocredit=-1\2/" /etc/security/pwquality.conf || echo "ocredit=-1" >> /etc/security/pwquality.conf
  egrep -q "^(\s*)lcredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)lcredit\s*=\s*\S+(\s*#.*)?\s*$/\lcredit=-1\2/" /etc/security/pwquality.conf || echo "lcredit=-1" >> /etc/security/pwquality.conf
  egrep -q "^\s*password\s+requisite\s+pam_pwquality.so\s+" /etc/pam.d/system-auth && sed -ri '/^\s*password\s+requisite\s+pam_pwquality.so\s+/ { /^\s*password\s+requisite\s+pam_pwquality.so(\s+\S+)*(\s+try_first_pass)(\s+.*)?$/! s/^(\s*password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1try_first_pass \2/ }' /etc/pam.d/system-auth && sed -ri '/^\s*password\s+requisite\s+pam_pwquality.so\s+/ { /^\s*password\s+requisite\s+pam_pwquality.so(\s+\S+)*(\s+retry=[0-9]+)(\s+.*)?$/! s/^(\s*password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1retry=3 \2/ }' /etc/pam.d/system-auth && sed -ri 's/(^\s*password\s+requisite\s+pam_pwquality.so(\s+\S+)*\s+)retry=[0-9]+(\s+.*)?$/\1retry=3\3/' /etc/pam.d/system-auth || echo Set\ Password\ Creation\ Requirement\ Parameters\ Using\ pam_pwquality - /etc/pam.d/system-auth not configured.

 # Limit Password Reuse
  echo
  echo \*\*\*\* Limit\ Password\ Reuse
  egrep -q "^\s*password\s+sufficient\s+pam_unix.so(\s+.*)$" /etc/pam.d/system-auth && sed -ri '/^\s*password\s+sufficient\s+pam_unix.so\s+/ { /^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*(\s+remember=[0-9]+)(\s+.*)?$/! s/^(\s*password\s+sufficient\s+pam_unix.so\s+)(.*)$/\1remember=5 \2/ }' /etc/pam.d/system-auth && sed -ri 's/(^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*\s+)remember=[0-9]+(\s+.*)?$/\1remember=5\3/' /etc/pam.d/system-auth || echo Limit\ Password\ Reuse - /etc/pam.d/system-auth not configured.
  
  egrep -q "^(\s*)SELINUXTYPE\s*=\s*\S+(\s*#.*)?\s*$" /etc/selinux/config && sed -ri "s/^(\s*)SELINUXTYPE\s*=\s*\S+(\s*#.*)?\s*$/\SELINUXTYPE=targeted\2/" /etc/selinux/config || echo "SELINUXTYPE=targeted" >> /etc/selinux/config
  egrep -q "^(\s*)SELINUX\s*=\s*\S+(\s*#.*)?\s*$" /etc/selinux/config && sed -ri "s/^(\s*)SELINUX\s*=\s*\S+(\s*#.*)?\s*$/\SELINUX=enforcing\2/" /etc/selinux/config || echo "SELINUX=enforcing" >> /etc/selinux/config

 # Restrict Access to the su Command
  cp /etc/pam.d/su /tmp/cis_config_files/su-original
  echo
  echo \*\*\*\* Restrict\ Access\ to\ the\ su\ Command
  egrep -q "^\s*auth\s+required\s+pam_wheel.so(\s+.*)?$" /etc/pam.d/su && sed -ri '/^\s*auth\s+required\s+pam_wheel.so(\s+.*)?$/ { /^\s*auth\s+required\s+pam_wheel.so(\s+\S+)*(\s+use_uid)(\s+.*)?$/! s/^(\s*auth\s+required\s+pam_wheel.so)(\s+.*)?$/\1 use_uid\2/ }' /etc/pam.d/su || echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su
  

   # Disable System Accounts
  echo
  echo \*\*\*\* Disable\ System\ Accounts
  for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd`; do
    if [ $user != "root" ]
    then
      /usr/sbin/usermod -L $user
      if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]
      then
        /usr/sbin/usermod -s /sbin/nologin $user
      fi
    fi
  done


  # Set Default Group for root Account
  echo
  echo \*\*\*\* Set\ Default\ Group\ for\ root\ Account
  usermod -g 0 root

  # Set Default umask for Users
  echo
  echo \*\*\*\* Set\ Default\ umask\ for\ Users
  egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/bashrc && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/bashrc || echo "umask 077" >> /etc/bashrc
  egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/profile.d/cis.sh && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/profile.d/cis.sh || echo "umask 077" >> /etc/profile.d/cis.sh
  
  # TMOUT information
  echo
  echo \*\*\*\* TMOUT\ etc-bashrc\ information

  egrep -q "^(\s*)TMOUT\s*=\s*\S+(\s*#.*)?\s*$" /etc/profile && sed -ri "s/^(\s*)TMOUT\s*=\s*\S+(\s*#.*)?\s*$/\TMOUT=600\2/" /etc/profile || echo "TMOUT=600" >> /etc/profile
  egrep -q "^(\s*)TMOUT\s*=\s*\S+(\s*#.*)?\s*$" /etc/bashrc && sed -ri "s/^(\s*)TMOUT\s*=\s*\S+(\s*#.*)?\s*$/\TMOUT=600\2/" /etc/bashrc || echo "TMOUT=600" >> /etc/bashrc

  # Lock Inactive User Accounts
  echo
  echo \*\*\*\* Lock\ Inactive\ User\ Accounts
  useradd -D -f 35

  # Set Warning Banner for Standard Login Services
  echo
  echo \*\*\*\* Set\ Warning\ Banner\ for\ Standard\ Login\ Services
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/motd
  chown 0:0 /etc/motd
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/issue
  chown 0:0 /etc/issue
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/issue.net
  chown 0:0 /etc/issue.net

  # Remove OS Information from Login Warning Banners
  echo
  echo \*\*\*\* Remove\ OS\ Information\ from\ Login\ Warning\ Banners
  sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/issue
  sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/issue.net
  sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/motd

  # Verify Permissions on /etc/passwd
  echo
  echo \*\*\*\* Verify\ Permissions\ on\ /etc/passwd
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/passwd

  # Verify Permissions on /etc/passwd-
  echo
  echo \*\*\*\* Verify\ Permissions\ on\ /etc/passwd
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/passwd-

  # Verify Permissions on /etc/shadow
  echo
  echo \*\*\*\* Verify\ Permissions\ on\ /etc/shadow
  chmod u-r-w-x,g-r-w-x,o-r-w-x /etc/shadow

  # Verify Permissions on /etc/gshadow
  echo
  echo \*\*\*\* Verify\ Permissions\ on\ /etc/gshadow
  chmod u-r-w-x,g-r-w-x,o-r-w-x /etc/gshadow

  # Verify Permissions on /etc/group
  echo
  echo \*\*\*\* Verify\ Permissions\ on\ /etc/group
  chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/group

  # Verify User/Group Ownership on /etc/passwd
  echo
  echo \*\*\*\* Verify\ User/Group\ Ownership\ on\ /etc/passwd
  chown 0:0 /etc/passwd

  # Verify User/Group Ownership on /etc/passwd
  echo
  echo \*\*\*\* Verify\ User/Group\ Ownership\ on\ /etc/passwd
  chown 0:0 /etc/passwd-

  # Verify User/Group Ownership on /etc/shadow
  echo
  echo \*\*\*\* Verify\ User/Group\ Ownership\ on\ /etc/shadow
  chown 0:0 /etc/shadow

  # Verify User/Group Ownership on /etc/gshadow
  echo
  echo \*\*\*\* Verify\ User/Group\ Ownership\ on\ /etc/gshadow
  chown 0:0 /etc/gshadow

  # Verify User/Group Ownership on /etc/group
  echo
  echo \*\*\*\* Verify\ User/Group\ Ownership\ on\ /etc/group
  chown 0:0 /etc/group

#   # Find Un-owned Files and Directories
#   echo
#   echo \*\*\*\* Find\ Un-owned\ Files\ and\ Directories
#   echo Find\ Un-owned\ Files\ and\ Directories not configured.

#   # Find Un-grouped Files and Directories
#   echo
#   echo \*\*\*\* Find\ Un-grouped\ Files\ and\ Directories
#   echo Find\ Un-grouped\ Files\ and\ Directories not configured.

#   Ensure Password Fields are Not Empty
#   echo
#   echo \*\*\*\* Ensure\ Password\ Fields\ are\ Not\ Empty
#   echo Ensure\ Password\ Fields\ are\ Not\ Empty not configured.

#   # Verify No Legacy &quot;+&quot; Entries Exist in /etc/passwd File
#   echo
#   echo \*\*\*\* Verify\ No\ Legacy\ \&quot\;\+\&quot\;\ Entries\ Exist\ in\ /etc/passwd\ File
#   sed -ri '/^\+:.*$/ d' /etc/passwd

#   # Verify No Legacy &quot;+&quot; Entries Exist in /etc/shadow File
#   echo
#   echo \*\*\*\* Verify\ No\ Legacy\ \&quot\;\+\&quot\;\ Entries\ Exist\ in\ /etc/shadow\ File
#   sed -ri '/^\+:.*$/ d' /etc/shadow

#   # Verify No Legacy &quot;+&quot; Entries Exist in /etc/group File
#   echo
#   echo \*\*\*\* Verify\ No\ Legacy\ \&quot\;\+\&quot\;\ Entries\ Exist\ in\ /etc/group\ File
#   sed -ri '/^\+:.*$/ d' /etc/group

echo " *************** END PWQUALITY *************** "