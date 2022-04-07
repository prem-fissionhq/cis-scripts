#!/bin/bash

echo " *************** START SSHD *************** "
 
  mkdir -p /opt/config_files_backup
  backupfile=$(date +'%Y_%d_%m_%H:%M')
  cp  /etc/ssh/sshd_config /opt/config_files_backup/sshd_config-${backupfile}        # sshd_config file backup

 # Set Permissions on /etc/ssh/sshd_config
  echo
  echo \*\*\*\* Set\ Permissions\ on\ /etc/ssh/sshd_config
  chown 0:0 /etc/ssh/sshd_config
  chmod u+r+w-x,g-r-w-x,o-r-w-x /etc/ssh/sshd_config

  chmod 600 /etc/ssh/*_key
  chown 0:0 /etc/ssh/*_key

  chmod 644 /etc/ssh/*.pub
  chmod 0:0 /etc/ssh/*.pub

 # Set LogLevel to INFO
  echo
  echo \*\*\*\* Set\ LogLevel\ to\ INFO
  egrep -q "^(\s*)LogLevel\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)LogLevel\s+\S+(\s*#.*)?\s*$/\1LogLevel INFO\2/" /etc/ssh/sshd_config || echo "LogLevel INFO" >> /etc/ssh/sshd_config

 # Disable SSH X11 Forwarding
  echo
  echo \*\*\*\* Disable\ SSH\ X11\ Forwarding
  egrep -q "^(\s*)X11Forwarding\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)X11Forwarding\s+\S+(\s*#.*)?\s*$/\1X11Forwarding no\2/" /etc/ssh/sshd_config || echo "X11Forwarding no" >> /etc/ssh/sshd_config

 # Set SSH Protocol to 2
  cp /etc/ssh/sshd_config /tmp/cis_config_files/sshd_config-original
  echo
  echo \*\*\*\* Set\ SSH\ Protocol\ to\ 2
  egrep -q "^(\s*)Protocol\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)Protocol\s+\S+(\s*#.*)?\s*$/\1Protocol 2\2/" /etc/ssh/sshd_config || echo "Protocol 2" >> /etc/ssh/sshd_config

  
 # Set SSH MaxAuthTries to 4 or Less
  echo
  echo \*\*\*\* Set\ SSH\ MaxAuthTries\ to\ 4\ or\ Less
  egrep -q "^(\s*)MaxAuthTries\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)MaxAuthTries\s+\S+(\s*#.*)?\s*$/\1MaxAuthTries 4\2/" /etc/ssh/sshd_config || echo "MaxAuthTries 4" >> /etc/ssh/sshd_config

 # Set SSH IgnoreRhosts to Yes
  echo
  echo \*\*\*\* Set\ SSH\ IgnoreRhosts\ to\ Yes
  egrep -q "^(\s*)IgnoreRhosts\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)IgnoreRhosts\s+\S+(\s*#.*)?\s*$/\1IgnoreRhosts yes\2/" /etc/ssh/sshd_config || echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config

 # Set SSH HostbasedAuthentication to No
  echo
  echo \*\*\*\* Set\ SSH\ HostbasedAuthentication\ to\ No
  egrep -q "^(\s*)HostbasedAuthentication\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)HostbasedAuthentication\s+\S+(\s*#.*)?\s*$/\1HostbasedAuthentication no\2/" /etc/ssh/sshd_config || echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config

 # Disable SSH Root Login
  echo
  echo \*\*\*\* Disable\ SSH\ Root\ Login
  egrep -q "^(\s*)PermitRootLogin\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)PermitRootLogin\s+\S+(\s*#.*)?\s*$/\1PermitRootLogin no\2/" /etc/ssh/sshd_config || echo "PermitRootLogin no" >> /etc/ssh/sshd_config

 # Set SSH PermitEmptyPasswords to No
  echo
  echo \*\*\*\* Set\ SSH\ PermitEmptyPasswords\ to\ No
 # egrep -q "^(\s*)PermitEmptyPasswords\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)PermitEmptyPasswords\s+\S+(\s*#.*)?\s*$/\1PermitEmptyPasswords no\2/" /etc/ssh/sshd_config || echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

 # Do Not Allow Users to Set Environment Options
  echo
  echo \*\*\*\* Do\ Not\ Allow\ Users\ to\ Set\ Environment\ Options
  egrep -q "^(\s*)PermitUserEnvironment\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)PermitUserEnvironment\s+\S+(\s*#.*)?\s*$/\1PermitUserEnvironment no\2/" /etc/ssh/sshd_config || echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config

 # Use Only Approved Cipher in Counter Mode
  echo
  echo \*\*\*\* Use\ Only\ Approved\ Cipher\ in\ Counter\ Mode
  egrep -q "^(\s*)Ciphers\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)Ciphers\s+\S+(\s*#.*)?\s*$/\1Ciphers 3des-cbc,aes128-cbc,aes192-cbc,aes256-cbc,arcfour,arcfour128,arcfour256,blowfish-cbc,cast128-cbc,rijndael-cbc@lysator.liu.se\2/" /etc/ssh/sshd_config || echo "Ciphers 3des-cbc,aes128-cbc,aes192-cbc,aes256-cbc,arcfour,arcfour128,arcfour256,blowfish-cbc,cast128-cbc,rijndael-cbc@lysator.liu.se" >> /etc/ssh/sshd_config

 # Use Only Approved MACs in Counter Mode
  echo
  echo \*\*\*\* Use\ Only\ Approved\ Cipher\ in\ Counter\ Mode
  egrep -q "^(\s*)MACs\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)MACs\s+\S+(\s*#.*)?\s*$/\1MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256\2/" /etc/ssh/sshd_config || echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256" >> /etc/ssh/sshd_config

  # Use Only Approved KexAlgorithms in Counter Mode
  echo
  echo \*\*\*\* Use\ Only\ Approved\ Cipher\ in\ Counter\ Mode
  egrep -q "^(\s*)KexAlgorithms\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)KexAlgorithms\s+\S+(\s*#.*)?\s*$/\1KexAlgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1\2/" /etc/ssh/sshd_config || echo "KexAlgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1" >> /etc/ssh/sshd_config

 # Set Idle Timeout Interval for User Login
  echo
  echo \*\*\*\* Set\ Idle\ Timeout\ Interval\ for\ User\ Login
  egrep -q "^(\s*)ClientAliveInterval\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)ClientAliveInterval\s+\S+(\s*#.*)?\s*$/\1ClientAliveInterval 300\2/" /etc/ssh/sshd_config || echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
  egrep -q "^(\s*)ClientAliveCountMax\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)ClientAliveCountMax\s+\S+(\s*#.*)?\s*$/\1ClientAliveCountMax 0\2/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config

 # Login GraceTime for User Login
  egrep -q "^(\s*)LoginGraceTime\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)LoginGraceTime\s+\S+(\s*#.*)?\s*$/\1LoginGraceTime 60\2/" /etc/ssh/sshd_config || echo "LoginGraceTime 60" >> /etc/ssh/sshd_config 


 # Limit Access via SSH
  echo
  echo \*\*\*\* Limit\ Access\ via\ SSH
  echo Limit\ Access\ via\ SSH not configured.

 # Set SSH Banner
  echo
  echo \*\*\*\* Set\ SSH\ Banner
 # egrep -q "^(\s*)Banner\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)Banner\s+\S+(\s*#.*)?\s*$/\1Banner /etc/issue.net\2/" /etc/ssh/sshd_config || echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
  a=$(cat /etc/ssh/sshd_config | grep 'Banner /etc/issue.net')
  c='Banner /etc/issue.net'
  if [ "$a" != "$c" ]
  then
        echo 'Banner /etc/issue.net' >> /etc/ssh/sshd_config
        echo "Updated"
  elif [ "$a" == "$c" ]
  then
        echo "Change already present 2"
  fi

 # Parameter UsePAM 
  egrep -q "^(\s*)UsePAM\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)UsePAM\s+\S+(\s*#.*)?\s*$/\1UsePAM yes\2/" /etc/ssh/sshd_config || echo "UsePAM yes" >> /etc/ssh/sshd_config 

 # Allow TCP fowrwarding
  egrep -q "^(\s*)AllowTcpForwarding\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)AllowTcpForwarding\s+\S+(\s*#.*)?\s*$/\1AllowTcpForwarding no\2/" /etc/ssh/sshd_config || echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config

 # MaxStartups
  egrep -q "^(\s*)MaxStartups\s+\S+(\s*#.*)?\s*$" /etc/ssh/sshd_config && sed -ri "s/^(\s*)MaxStartups\s+\S+(\s*#.*)?\s*$/\1MaxStartups 10:30:60\2/" /etc/ssh/sshd_config || echo "MaxStartups 10:30:60" >> /etc/ssh/sshd_config 

 echo
 echo \*\*\*\* Restarting\ sshd\ service
 systemctl restart sshd.service

 
echo " *************** END SSHD *************** "