#!/bin/bash -xe

PORT=$1
CIDR=$2

sudo yum clean all 
sudo yum update -y

#To ensure NFS and RPC are not enabled
sudo chkconfig nfs off
sudo chkconfig rpcbind off

# Ensure AIDE(Advanced Intrusion Detection Environment) is installed, Configured and Initialized.
sudo yum install aide -y 
sudo aide --init
sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

#Ensure at cron is restricted permissions and ownership for /etc/cron.allow and /etc/at.allow 
sudo rm /etc/cron.deny
sudo rm /etc/at.deny
sudo touch /etc/cron.allow
sudo touch /etc/at.allow
sudo chmod og-rwx /etc/cron.allow
sudo chmod og-rwx /etc/at.allow
sudo chown root:root /etc/cron.allow
sudo chown root:root /etc/at.allow

#Ensure permissions on all logfiles are configured
sudo find /var/log -type f -exec chmod g-wx,o-rwx {} +

#Ensure permissions on etccron.hourly are configured.
sudo chown root:root /etc/cron.hourly
sudo chmod og-rwx /etc/cron.hourly
#Ensure permissions on etccron.weekly are configured.
sudo chown root:root /etc/cron.weekly
sudo chmod og-rwx /etc/cron.weekly
#Ensure permissions on etc/cron.d are configured.
sudo chown root:root /etc/cron.d
sudo chmod og-rwx /etc/cron.d
#Ensure permissions on etc/crontab are configured.
sudo chown root:root /etc/crontab
sudo chmod og-rwx /etc/crontab
#Ensure permissions on bootloader config are configured.
sudo chown root:root /boot/grub/menu.lst
sudo chmod og-rwx /boot/grub/menu.lst
#Ensure permissions on etc/cron.daily config are configured.
sudo chown root:root /etc/cron.daily
sudo chmod og-rwx /etc/cron.daily
#Ensure permissions on etc/cron.monthly config are configured.
sudo chown root:root /etc/cron.monthly
sudo chmod og-rwx /etc/cron.monthly

#Ensure X Window System is not installed.
sudo yum remove xorg-x11* -y

#Ensure inactive password lock is 30 days or less
sudo useradd -D -f 30

yum install libselinux libselinux-utils libselinux-utils selinux-policy-minimum selinux-policy-mls selinux-policy-targeted policycoreutils -y

#Ensure filesystem integrity is regularly checked
sudo crontab -l | { cat; echo "0 5 * * * /usr/sbin/aide --check"; } | crontab -

#Ensure system is disabled when audit logs are full
sudo sed -i 's/^space_left_action = .*/space_left_action = email/' /etc/audit/auditd.conf
sudo sed -i 's/^action_mail_acct = .*/action_mail_acct = root/' /etc/audit/auditd.conf
sudo sed -i 's/^admin_space_left_action = .*/admin_space_left_action = halt/' /etc/audit/auditd.conf
sudo sed -i 's/^max_log_file_action = .*/max_log_file_action = keep_logs/' /etc/audit/auditd.conf


#Ensure SSH root login is disabled
sudo sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
#Ensure SSH X11 forwarding is disabled
sudo sed -i 's/^X11Forwarding .*/X11Forwarding no/' /etc/ssh/sshd_config
sudo cat <<EOT >> /etc/ssh/sshd_config

#Ensure SSH LoginGraceTime is set to one minute or less
LoginGraceTime 60
#Ensure SSH HostbasedAuthentication is disabled
HostbasedAuthentication no
#Ensure SSH Idle Timeout Interval is configured
ClientAliveInterval 300
ClientAliveCountMax 0
#Ensure SSH LogLevel is set to INFO
LogLevel INFO
#Ensure SSH MaxAuthTries is set to 4 or less
MaxAuthTries 4
#Ensure SSH Protocol is set to 2
Protocol 2
#Ensure SSH PermitUserEnvironment is disabled
PermitUserEnvironment no
#Ensure SSH IgnoreRhosts is enabled
IgnoreRhosts yes
#Ensure SSH warning banner is configured
Banner /etc/issue.net
#Ensure SSH PermitEmptyPasswords is disabled
PermitEmptyPasswords no
#MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
#Ensure only approved MAC algorithms are used
MACs hmac-sha2-512,hmac-sha2-256
Ciphers aes256-ctr,aes192-ctr,aes128-ctr
#Ensure SSH access is limited
AllowUsers ec2-user
EOT
#Mkae sure /etc/ssh/sshd_config changes are enable.
sudo service sshd restart

#Ensure mounting of (hfs,jffs2,FAT,hfsplus,squashfs,freevxfs,udf and cramfs) filesystems,Ensure IPv6,TIPC,RDS,DCCP and SCTP are disabled is disabled
sudo touch /etc/modprobe.d/CIS.conf
sudo cat <<EOT >> /etc/modprobe.d/CIS.conf
install hfs /bin/true
install jffs2 /bin/true
install hfsplus /bin/true
install vfat /bin/true
install squashfs /bin/true
install freevxfs /bin/true
install udf /bin/true
install cramfs /bin/true
install rds /bin/true
install dccp /bin/true
options ipv6 disable=1
install sctp /bin/true
install tipc /bin/true
EOT

#Ensure interactive boot is not enabled.
sudo sed -i 's/PROMPT=yes/PROMPT=no/g' /etc/sysconfig/init
#Ensure authentication required for single user mode.
sudo sed -i 's/SINGLE=\/sbin\/sushell/SINGLE=\/sbin\/sulogin/g' /etc/sysconfig/init


#Ensure IPv6 redirects are not accepted
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
EOT
sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.route.flush=1

#Ensure Reverse Path Filtering is enabled.
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOT
sudo sysctl -w net.ipv4.conf.all.rp_filter=1
sudo sysctl -w net.ipv4.conf.default.rp_filter=1
sudo sysctl -w net.ipv4.route.flush=1

#Ensure ICMP redirects are not accepted.
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
EOT
sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

#Ensure IPv6 router advertisements are not accepted
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
EOT
sudo sysctl -w net.ipv6.conf.all.accept_ra=0
sudo sysctl -w net.ipv6.conf.default.accept_ra=0
sudo sysctl -w net.ipv6.route.flush=1

#Ensure secure ICMP redirects are not accepted
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
EOT
sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

#Ensure packet redirect sending is disabled
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOT
sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

#Ensure suspicious packets are logged and  dumps are restricted
sudo cat <<EOT >> /etc/sysctl.conf
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
fs.suid_dumpable = 0
EOT
sudo sysctl -w net.ipv4.conf.all.log_martians=1
sudo sysctl -w net.ipv4.conf.default.log_martians=1
sudo sysctl -w net.ipv4.route.flush=1

#Ensure access to the su command is restricted
sudo cat <<EOT >> /etc/pam.d/su
auth            required        pam_wheel.so use_uid
EOT
#Set users in wheel group match site policy:
sudo sed -i 's/wheel:x:10:ec2-user/wheel:x:10:root,ec2-user/' /etc/group


#Ensure minimum days between password changes is 7 or more
sudo sed -i "s/PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/g" /etc/login.defs
#Ensure password expiration is 90 days or less
sudo sed -i "s/PASS_MAX_DAYS.*/PASS_MAX_DAYS 90/g" /etc/login.defs

#To Ensure auditing for processes that start prior to auditd is enabled and  SELinux is  enabled in bootloader.
sudo sed -i 's/selinux=0/audit=1 selinux=1 security=selinux enforcing=1/g' /boot/grub/menu.lst

#Ensure SELinux policy is configured
sudo touch /etc/selinux/config
sudo cat <<EOT >> /etc/selinux/config
SELINUX=enforcing
SELINUXTYPE=targeted
EOT

#Ensure nodev,noexec,nosuid options set on devshm partition
sudo sed -i 's/tmpfs.*/tmpfs       \/dev\/shm    tmpfs   defaults,nodev,noexec,nosuid        0   0/g' /etc/fstab
sudo mount -a


#Ensure events that modify date, time information, file system mounts and network environment are collected
sudo cat <<EOT >> /etc/audit/audit.rules
-e 2
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit arch=b64 -S init_module -S delete_module -k modules
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k logins
-w /var/log/btmp -p wa -k logins
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock/ -p wa -k logins
-w /var/log/sudo.log -p wa -k actions
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
-w /etc/selinux/ -p wa -k MAC-policy
EOT

#To ensure /etc/audit/audit.rules file changes are effected
sudo service auditd restart

#Ensure lockout for failed password attempts, creation and reuse is configured
sudo cat <<EOT >> /etc/pam.d/password-auth
auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth [success=1 default=bad] pam_unix.soi
auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900
auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900
password sufficient pam_unix.so remember=5
password requisite pam_pwquality.so try_first_pass retry=3
EOT

#Ensure lockout for failed password attempts, creation and reuse is configured
sudo cat <<EOT >> /etc/pam.d/system-auth
auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth [success=1 default=bad] pam_unix.soi
auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900
auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900
password sufficient pam_unix.so remember=5
password requisite pam_pwquality.so try_first_pass retry=3
EOT

#Ensure local login warning banner is configured properly
sudo echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue
#Ensure remote login warning banner is configured properly
sudo echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net

#Ensure rsyslog default file permissions configured
sudo sed -i '$ a\$FileCreateMode 0640' /etc/rsyslog.conf

#Ensure default user shell timeout is 600 seconds or less
sudo cat <<EOT >> /etc/bashrc
TMOUT=600
readonly TMOUT
export TMOUT
EOT
sudo cat <<EOT >> /etc/profile
TMOUT=600
readonly TMOUT
export TMOUT
EOT

#Ensure default user umask is 027 or more restrictive
sudo sed -i "s/umask.*/umask 027/g"  /etc/bashrc
sudo sed -i "s/umask.*/umask 027/g"  /etc/profile

#Ensure password creation requirements are configured in site policy
sudo cat <<EOT >> /etc/security/pwquality.conf
minlen=14
dcredit=-1
ucredit=-1
ocredit=-1
lcredit=-1
EOT

#Ensure core dumps are restricted
sudo cat <<EOT >> /etc/security/limits.conf
* hard core 0
EOT

# set the active kernel parameter
sudo sysctl -w fs.suid_dumpable=0

sudo yum remove mcstrans -y

#Ensure permissions on /etc/ssh/sshd_config config are configured.
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/sshd_config


# Ensure etchosts.deny is configured to deny connections to the server
sudo cat <<EOT >> /etc/hosts.deny
sshd: ALL: allow
ALL: ALL
EOT

sudo cat <<EOT >> /etc/sysconfig/iptables
# Generated by iptables-save v1.4.18 on Wed Oct 10 17:19:53 2018
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT DROP [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -s 127.0.0.0/8 -j DROP
-A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
-A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
-A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT
-A INPUT -p udp -m udp --dport 68 -m state --state NEW -j ACCEPT
-A INPUT -p udp -m udp --dport 123 -m state --state NEW -j ACCEPT
-A INPUT -p udp -m udp --dport 323 -m state --state NEW -j ACCEPT
-A OUTPUT -o lo -j ACCEPT
-A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
COMMIT
# Completed on Wed Oct 10 17:19:53 2018
EOT

chkconfig iptables on
service iptables start
iptables -I INPUT 2 -p tcp -s $CIDR --dport $PORT -j ACCEPT
service iptables save
service iptables restart
#Enabling a Yum Repository 
sudo yum-config-manager --enable \*

#Ensure ntp is configured
sudo sed -i 's/restrict default .*/restrict default kod nomodify notrap nopeer noquery/g' /etc/ntp.conf
sudo cat <<EOT >> /etc/ntp.conf
restrict -6 default kod nomodify notrap nopeer noquery
EOT
sudo sed -i 's/OPTIONS=.*/OPTIONS="-g -u ntp:ntp"/g' /etc/sysconfig/ntpd