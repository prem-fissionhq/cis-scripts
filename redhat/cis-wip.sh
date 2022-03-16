a=$(cat /etc/ntp.conf | grep 'restrict default nomodify notrap nopeer noquery')
b=$a
c="restrict default nomodify notrap nopeer noquery"

if [ "$a" == "$c" ]
then
       a="#$a"   
        sed -i "/$b/ s/$b/$a/" /etc/ntp.conf # commenting existing line
        sed -i "/$a/a restrict -4 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        a="restrict -4 default kod nomodify notrap nopeer noquery"
        sed -i "/$a/a restrict -6 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 1"
fi

a=$(cat /etc/ntp.conf | grep 'restrict -6 default kod nomodify notrap nopeer noquery')
b=$a
c="restrict -6 default kod nomodify notrap nopeer noquery"
if [ "$a" == "" ]
then
        b="restrict -4 default kod nomodify notrap nopeer noquery"
        sed -i "/$b/a restrict -6 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        echo "Config Changed"
elif [ "$a" == "$c" ]
then
         echo "Change already present 1.1"
fi
systemctl restart ntpd


a=$(cat /etc/ntp.conf | grep 'server 0.rhel.pool.ntp.org iburst')
b=$a
c="server 0.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-g.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 2"
fi
a=$(cat /etc/ntp.conf | grep 'server 1.rhel.pool.ntp.org iburst')
b=$a
c="server 1.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-d-g.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 3"
fi
a=$(cat /etc/ntp.conf | grep 'server 2.rhel.pool.ntp.org iburst')
b=$a
c="server 2.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-wwv.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 4"
fi
a=$(cat /etc/ntp.conf | grep 'server 3.rhel.pool.ntp.org iburst')
b=$a
c="server 3.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-b.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 5"
fi
#---

a=$(grep "OPTIONS=" /etc/sysconfig/ntpd | sed -e 's/.*=//')
b=$a
c="-g"
if [ "$a" == "\"$c\"" ]
then
         a="${a//\"}"
         a="$a -u ntp:ntp"
         a="\"$a\""
         sed -i "/OPTIONS/ s/$b/$a/" /etc/sysconfig/ntpd
         echo "Config Changed"
elif [ "$a" == "\"-g -u ntp:ntp\"" ]
then
         echo "Change already present 6"
fi
systemctl restart ntpd


#====================================================================
#===================================================================


a=$(cat /etc/chrony.conf | grep 'server 0.rhel.pool.ntp.org iburst')
b=$a
c="server 0.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-g.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 7"
fi
a=$(cat /etc/chrony.conf | grep 'server 1.rhel.pool.ntp.org iburst')
b=$a
c="server 1.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-d-g.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 8"
fi
a=$(cat /etc/chrony.conf | grep 'server 2.rhel.pool.ntp.org iburst')
b=$a
c="server 2.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-wwv.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 9"
fi
a=$(cat /etc/chrony.conf | grep 'server 3.rhel.pool.ntp.org iburst')
b=$a
c="server 3.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-b.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 10"
fi

a=$(grep "OPTIONS=" /etc/sysconfig/chronyd | sed -e 's/.*=//')
b=$a
if [ "$a" == "\"\"" ]
then
        a="${a//\"}"
        a="$a -u chronyd"
        a="\"$a\""
        sed -i "/OPTIONS/ s/$b/$a/" /etc/sysconfig/chronyd
        echo "Config Changed"
elif [ "$a" == "\" -u chronyd\"" ]
then
         echo "Change already present 11"
fi


#==================================================================
#=================================================================

a=$(cat /etc/sysctl.conf | grep net.ipv4.ip_forward)
b=$a
c="net.ipv4.ip_forward"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.ip_forward = 0" ]
then
       echo "Change already present 12"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.secure_redirects)
b=$a
c="net.ipv4.conf.all.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.secure_redirects = 0" ]
then
       echo "Change already present 13"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.secure_redirects)
b=$a
c="net.ipv4.conf.default.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.secure_redirects = 0" ]
then
       echo "Change already present 14"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.log_martians)
b=$a
c="net.ipv4.conf.all.log_martians"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.log_martians = 1" ]
then
       echo "Change already present 15"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.log_martians)
b=$a
c="net.ipv4.conf.default.log_martians"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.log_martians = 1" ]
then
       echo "Change already present 16"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.icmp_ignore_bogus_error_responses)
b=$a
c="net.ipv4.icmp_ignore_bogus_error_responses"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]
then
       echo "Change already present 17"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.tcp_syncookies)
b=$a
c="net.ipv4.tcp_syncookies"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.tcp_syncookies = 1" ]
then
       echo "Change already present 18"
fi

sysctl -p

#=================================================================================
#================================================================================

systemctl disable snmpd
sed -i 's/^.*LogLevel.*$/LogLevel INFO/' /etc/ssh/sshd_config
sed -i 's/^.*MaxAuthTries.*$/MaxAuthTries 4/' /etc/ssh/sshd_config
systemctl restart sshd
echo "Changes done/completed sshd"


#================================================================================


a=$(cat /etc/sysctl.conf | grep fs.suid_dumpable)
b=$a
c="fs.suid_dumpable"
if [ "$a" == "" ]
then
         a="#$a"
         sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
         echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
         echo "Config Changed"
elif [ "$a" == "fs.suid_dumpable = 0" ]
then
         echo "Change already present 19"
fi
sysctl -p

a="*                hard    core            0" 
c=$(cat /etc/security/limits.conf | grep 'hard    core')
b=$c
d=$(cat /etc/security/limits.conf | grep '*                hard    core            0')
if [ "$d" != "*                hard    core            0" ]
then
         c="#$c"
         sed -i "/$b/ s/$b/$c/" /etc/security/limits.conf
         sed -i "/#@student        -       maxlogins       4/a $a" /etc/security/limits.conf
         echo "Config Changed"
else
         echo "Change already present 20"
fi


# New script lines
if [ ! -e /etc/modprobe.d/blacklist.conf ]; then
    mkdir -p /etc/modprobe.d
    touch /etc/modprobe.d/blacklist.conf
fi

echo -e "install cramfs /bin/true\ninstall freevxfs /bin/true\ninstall jffs2 /bin/true\ninstall hfs /bin/true\ninstall hfsplus /bin/true\ninstall squashfs /bin/true\ninstall udf /bin/true\ninstall usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf

# Status of the 'core dump' (hard) setting

if [ ! -e /etc/security/limits.conf ]; then
    mkdir -p /etc/security
    touch /etc/security/limits.conf
fi

echo -e "* soft core 0\n* hard core 0" >> /etc/security/limits.conf

if [ ! -e /etc/sysctl.conf ]; then
    touch /etc/sysctl.conf
fi
sed -i '/fs.suid_dumpable/s/= .*/= 0/' /etc/sysctl.conf
sysctl -w fs.suid_dumpable=0

sysctl -p

# net.ipv4.ip_forward
echo -e "net.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv4.conf.all.secure_redirects = 0\nnet.ipv4.conf.default.secure_redirects = 0\nnet.ipv4.conf.all.log_martians = 0" >> /etc/sysctl.conf

echo -e "net.ipv6.conf.all.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_ra\nnet.ipv6.conf.all.accept_ra" >> /etc/sysctl.conf

sysctl -p

# firewalld installation
yum install firewalld -y
firewall-cmd --list-all
systemctl start firewalld
systemctl status firewalld

# 65,66,67
sed -i '/max_log_file_action/s/= .*/= KEEP_LOGS/' /etc/audit/auditd.conf
sed -i '/space_left_action/s/= .*/= EMAIL/' /etc/audit/auditd.conf
sed -i '/admin_space_left_action/s/= .*/= HALT/' /etc/audit/auditd.conf

# 68
echo “audit_backlog_limit=8192” >> /boot/grub2/grub.cfg

# 71,72,73

echo “-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S stime -S clock_settime -k time-change” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -F arch=b64 -S sethostname -S system_call  -S setdomainname -k system-locale” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -S chmod -S fchmod -S fchmodat” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -S chown -S fchown -S fchownat -S lchown” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -S truncate -S ftruncate” >> /etc/audit/rules.d/audit.rules

echo “-a entry,always -S setxattr” >> /etc/audit/rules.d/audit.rules
echo “-a entry,always -S lsetxattr” >> /etc/audit/rules.d/audit.rules
echo “-a entry,always -S fsetxattr” >> /etc/audit/rules.d/audit.rules

echo “-a entry,always -S removexattr” >> /etc/audit/rules.d/audit.rules
echo “-a entry,always -S lremovexattr” >> /etc/audit/rules.d/audit.rules
echo “-a entry,always -S fremovexattr” >> /etc/audit/rules.d/audit.rules

echo “-a entry,always -S open -S openat -S creat ” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k privileged” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -F arch=b64 -S init_module -S delete_module -k modules -F exit=0” >> /etc/audit/rules.d/audit.rules

echo “-a always,exit -S mount -S execve” >> /etc/audit/rules.d/audit.rules

# _____________________________________________________________________

echo “-w /etc/selinux/ -p wa -k selinux_changes” >> /etc/audit/rules.d/audit.rules

echo “-w /var/log/lastlog -p wa -k logins” >> /etc/audit/rules.d/audit.rules
echo “-w /var/run/faillock/ -p wa -k logins” >> /etc/audit/rules.d/audit.rules

echo “-w /var/run/utmp -p wa -k session” >> /etc/audit/rules.d/audit.rules
echo “-w /var/log/wtmp -p wa -k session” >> /etc/audit/rules.d/audit.rules
echo “-w /var/log/btmp -p wa -k session” >> /etc/audit/rules.d/audit.rules

echo “-w /sbin/insmod -p x -k module_insertion” >> /etc/audit/rules.d/audit.rules
echo “-w /sbin/rmmod -p x -k modules” >> /etc/audit/rules.d/audit.rules
echo “-w /sbin/modprobe -p x -k modules” >> /etc/audit/rules.d/audit.rules


echo “-w /etc/sudoers -p wa -k sudo_actions” >> /etc/audit/rules.d/audit.rules
echo “-a always,exit -S sudo -k sudo_actions” >> /etc/audit/rules.d/audit.rules

# echo “-w /usr/bin/chmod -p x -k chmod_rule” >> /etc/audit/rules.d/audit.rules
# echo “-w /usr/bin/chown -p x -k chown_rule” >> /etc/audit/rules.d/audit.rules


chmod 750 /etc/at.deny
chmod 752 /etc/crontab
chmod 750 /etc/cron.hourly
chmod 750 /etc/cron.daily
chmod 750 /etc/cron.weekly
chmod 750 /etc/cron.monthly

# _____________________________________________________________________

echo “Defaults   use_pty” >> /etc/sudoers
echo “Defaults   logfile="/var/log/sudo.log"” >> /etc/sudoers

chmod 710 /etc/ssh/*
chown root:root /etc/ssh/*

sed -i '/X11Forwarding/s/= .*/= no/' /etc/ssh/sshd_config
echo “MaxAuthTries 4” >> /etc/ssh/sshd_config
echo “PermitRootLogin no” >> /etc/ssh/sshd_config

echo “Ciphers 3des-cbc,aes128-cbc,aes192-cbc,aes256-cbc,arcfour,arcfour128,arcfour256,blowfish-cbc,cast128-cbc,rijndael-cbc@lysator.liu.se” >> /etc/ssh/sshd_config

echo “MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256”

echo “kexalgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1” >> /etc/ssh/sshd_config

echo "LoginGraceTime 60" >> /etc/ssh/sshd_config
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
echo "MaxStartups 10:30:60" >> /etc/ssh/sshd_config

sed -i '/minlen/s/= .*/= 12/' /etc/security/pwquality.conf
sed -i '/minclass/s/= .*/= 4/' /etc/security/pwquality.conf
sed -i '/dcredit/s/= .*/= -1/' /etc/security/pwquality.conf
sed -i '/ucredit/s/= .*/= -1/' /etc/security/pwquality.conf
sed -i '/lcredit/s/= .*/= -1/' /etc/security/pwquality.conf

echo "auth     required     pam_faillock.so" >> /etc/pam.d/system-auth
echo "auth     required     pam_faillock.so" >> /etc/pam.d/password-auth

echo "password required pam_pwhistory.so debug use_authtok remember=5" >> /etc/pam.d/system-auth
echo "password required pam_pwhistory.so debug use_authtok remember=5" >> /etc/pam.d/password-auth

sed -i '/PASS_MAX_DAYS/s/= .*/= 90/' /etc/login.defs

echo "export TMOUT=900" >> /etc/bashrc
echo "export TMOUT=900" >> /etc/profile

sed -i '/umask/s/= .*/= 077/' /etc/profile
sed -i '/umask/s/= .*/= 077/' /etc/bashrc

echo "auth     required     pam_wheel.so     use_uid" >> /etc/pam.d/su
