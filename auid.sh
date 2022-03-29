#!/bin/sh

echo " *************** START Installing AUID and Removing setroubleshoot, mcstrans, xinetd *************** "

 # Install AIDE
  echo
  echo \*\*\*\* Install\ AIDE
  rpm -q aide || yum -y install aide

  # Implement Periodic Execution of File Integrity
  echo
  echo \*\*\*\* Implement\ Periodic\ Execution\ of\ File\ Integrity
  (crontab -u root -l; crontab -u root -l | egrep -q "^0 5 \* \* \* /usr/sbin/aide --check$" || echo "0 5 * * * /usr/sbin/aide --check" ) | crontab -u root -

  # Remove SETroubleshoot
  echo
  echo \*\*\*\* Remove\ SETroubleshoot
  rpm -q setroubleshoot && yum -y remove setroubleshoot

  # Remove MCS Translation Service (mcstrans)
  echo
  echo \*\*\*\* Remove\ MCS\ Translation\ Service\ \(mcstrans\)
  rpm -q mcstrans && yum -y remove mcstrans

  # Check for Unconfined Daemons
  echo
  echo \*\*\*\* Check\ for\ Unconfined\ Daemons
  echo Check\ for\ Unconfined\ Daemons not configured.

  # Remove xinetd
  echo
  echo \*\*\*\* Remove\ xinetd
  rpm -q xinetd && yum -y remove xinetd

  # Remove telnet-server
  echo
  echo \*\*\*\* Remove\ telnet-server
  rpm -q telnet-server && yum -y remove telnet-server

  # Remove telnet Clients
  echo
  echo \*\*\*\* Remove\ telnet\ Clients
  rpm -q telnet && yum -y remove telnet

  # Remove rsh-server
  echo
  echo \*\*\*\* Remove\ rsh-server
  rpm -q rsh-server && yum -y remove rsh-server

  # Remove rsh
  echo
  echo \*\*\*\* Remove\ rsh
  rpm -q rsh && yum -y remove rsh

  # Remove NIS Client
  echo
  echo \*\*\*\* Remove\ NIS\ Client
  rpm -q ypbind && yum -y remove ypbind

  # Remove NIS Server
  echo
  echo \*\*\*\* Remove\ NIS\ Server
  rpm -q ypserv && yum -y remove ypserv

  # Remove tftp
  echo
  echo \*\*\*\* Remove\ tftp
  rpm -q tftp && yum -y remove tftp

  # Remove tftp-server
  echo
  echo \*\*\*\* Remove\ tftp-server
  rpm -q tftp-server && yum -y remove tftp-server

  # Remove talk
  echo
  echo \*\*\*\* Remove\ talk
  rpm -q talk && yum -y remove talk

  # Remove talk-server
  echo
  echo \*\*\*\* Remove\ talk-server
  rpm -q talk-server && yum -y remove talk-server

  # Disable chargen-dgram
  echo
  echo \*\*\*\* Disable\ chargen-dgram
  rpm -q xinetd && chkconfig chargen-dgram off

  # Disable chargen-stream
  echo
  echo \*\*\*\* Disable\ chargen-stream
  rpm -q xinetd && chkconfig chargen-stream off

  # Disable daytime-dgram
  echo
  echo \*\*\*\* Disable\ daytime-dgram
  rpm -q xinetd && chkconfig daytime-dgram off

  # Disable daytime-stream
  echo
  echo \*\*\*\* Disable\ daytime-stream
  rpm -q xinetd && chkconfig daytime-stream off

  # Disable echo-dgram
  echo
  echo \*\*\*\* Disable\ echo-dgram
  rpm -q xinetd && chkconfig echo-dgram off

  # Disable echo-stream
  echo
  echo \*\*\*\* Disable\ echo-stream
  rpm -q xinetd && chkconfig echo-stream off

  # Disable tcpmux-server
  echo
  echo \*\*\*\* Disable\ tcpmux-server
  rpm -q xinetd && chkconfig tcpmux-server off

  # Remove the X Window System
  echo
  echo \*\*\*\* Remove\ the\ X\ Window\ System
  rpm -q xorg-x11-server-common && yum -y remove xorg-x11-server-common
  unlink /etc/systemd/system/default.target
  ln -s /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target

  # Disable Avahi Server
  echo
  echo \*\*\*\* Disable\ Avahi\ Server
  systemctl disable avahi.service

  # Disable Print Server - CUPS
  echo
  echo \*\*\*\* Disable\ Print\ Server\ -\ CUPS
  systemctl disable cups.service

  # Remove DHCP Server
  echo
  echo \*\*\*\* Remove\ DHCP\ Server
  rpm -q dhcp && yum -y remove dhcp

  # Remove LDAP
  echo
  echo \*\*\*\* Remove\ LDAP
  rpm -q openldap-servers && yum -y remove openldap-servers
  rpm -q openldap-clients && yum -y remove openldap-clients

  # Disable NFS and RPC
  echo
  echo \*\*\*\* Disable\ NFS\ and\ RPC
  systemctl disable nfslock
  systemctl disable rpcgssd
  systemctl disable rpcbind
  systemctl disable rpcidmapd
  systemctl disable rpcsvcgssd

  Remove DNS Server
  echo
  echo \*\*\*\* Remove\ DNS\ Server
  rpm -q bind && yum -y remove bind

  # Remove FTP Server
  echo
  echo \*\*\*\* Remove\ FTP\ Server
  rpm -q vsftpd && yum -y remove vsftpd

  # Remove HTTP Server
  echo
  echo \*\*\*\* Remove\ HTTP\ Server
  rpm -q httpd && yum -y remove httpd

  # Remove Dovecot (IMAP and POP3 services)
  echo
  echo \*\*\*\* Remove\ Dovecot\ \(IMAP\ and\ POP3\ services\)
  rpm -q dovecot && yum -y remove dovecot

  # Remove Samba
  echo
  echo \*\*\*\* Remove\ Samba
  rpm -q samba && yum -y remove samba

  Remove HTTP Proxy Server
  echo
  echo \*\*\*\* Remove\ HTTP\ Proxy\ Server
  rpm -q squid && yum -y remove squid

  Remove SNMP Server
  echo
  echo \*\*\*\* Remove\ SNMP\ Server
  rpm -q net-snmp && yum -y remove net-snmp

  echo " *************** END Installing AUID and Removing setroubleshoot, mcstrans, xinetd *************** "