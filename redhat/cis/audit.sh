#!/bin/sh

cp /etc/audit/rules.d/audit.rules /tmp/audit.rules

echo '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S stime -S clock_settime -k time-change' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -F arch=b64 -S sethostname -S system_call  -S setdomainname -k system-locale' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -S chmod -S fchmod -S fchmodat' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -S chown -S fchown -S fchownat -S lchown' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -S truncate -S ftruncate' >> /etc/audit/rules.d/audit.rules

echo '-a entry,always -S setxattr' >> /etc/audit/rules.d/audit.rules
echo '-a entry,always -S lsetxattr' >> /etc/audit/rules.d/audit.rules
echo '-a entry,always -S fsetxattr' >> /etc/audit/rules.d/audit.rules

echo '-a entry,always -S removexattr' >> /etc/audit/rules.d/audit.rules
echo '-a entry,always -S lremovexattr' >> /etc/audit/rules.d/audit.rules
echo '-a entry,always -S fremovexattr' >> /etc/audit/rules.d/audit.rules

echo '-a entry,always -S open -S openat -S creat' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -S unlink -S unlinkat -S rename -S renameat' >> /etc/audit/rules.d/audit.rules
# echo '-a always,exit -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k privileged' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules -F exit=0' >> /etc/audit/rules.d/audit.rules

echo '-a always,exit -S mount -S execve' >> /etc/audit/rules.d/audit.rules

echo '-w /etc/selinux/ -p wa -k selinux_changes' >> /etc/audit/rules.d/audit.rules

echo '-w /var/log/lastlog -p wa -k logins' >> /etc/audit/rules.d/audit.rules
echo '-w /var/run/faillock/ -p wa -k logins' >> /etc/audit/rules.d/audit.rules

echo '-w /var/run/utmp -p wa -k session' >> /etc/audit/rules.d/audit.rules
echo '-w /var/log/wtmp -p wa -k session' >> /etc/audit/rules.d/audit.rules
echo '-w /var/log/btmp -p wa -k session' >> /etc/audit/rules.d/audit.rules

echo '-w /sbin/insmod -p x -k module_insertion' >> /etc/audit/rules.d/audit.rules
echo '-w /sbin/rmmod -p x -k modules' >> /etc/audit/rules.d/audit.rules
echo '-w /sbin/modprobe -p x -k modules' >> /etc/audit/rules.d/audit.rules

echo '-w /etc/sudoers -p wa -k sudo_actions' >> /etc/audit/rules.d/audit.rules
echo '-a always,exit -S sudo -k sudo_actions' >> /etc/audit/rules.d/audit.rules

echo '-w /usr/bin/chmod -p x -k chmod_rule' >> /etc/audit/rules.d/audit.rules
echo '-w /usr/bin/chown -p x -k chown_rule' >> /etc/audit/rules.d/audit.rules
