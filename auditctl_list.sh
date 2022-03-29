#!/bin/bash

echo " *************** START AUDITCTL LIST *************** "
auditctl -b 8192
auditctl -f 1
auditctl -a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k time-change
auditctl -a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
auditctl -a always,exit -F arch=b64 -S init_module -S delete_module -k modules -F exit=0
auditctl -w /etc/selinux/ -p wa -k selinux_changes
auditctl -w /var/log/lastlog -p wa -k logins
auditctl -w /var/run/faillock/ -p wa -k logins
auditctl -w /var/log/faillog -p wa -k logins
auditctl -w /var/log/tallylog -p wa -k logins
auditctl -w /var/run/utmp -p wa -k session
auditctl -w /var/log/wtmp -p wa -k session
auditctl -w /var/log/btmp -p wa -k session
auditctl -w /sbin/insmod -p x -k module_insertion
auditctl -w /sbin/insmod -p x -k modules
auditctl -w /sbin/rmmod -p x -k modules
auditctl -w /sbin/modprobe -p x -k modules
auditctl -w /etc/sudoers -p wa -k sudo_actions
auditctl -w /usr/bin/chmod -p x -k chmod_rule
auditctl -w /usr/bin/chown -p x -k chown_rule
auditctl -w /etc/localtime -p wa -k time-change
auditctl -w /etc/group -p wa -k identity
auditctl -w /etc/passwd -p wa -k identity
auditctl -w /etc/gshadow -p wa -k identity
auditctl -w /etc/shadow -p wa -k identity
auditctl -w /etc/security/opasswd -p wa -k identity
auditctl -w /etc/issue -p wa -k system-locale
auditctl -w /etc/issue.net -p wa -k system-locale
auditctl -w /etc/hosts -p wa -k system-locale
auditctl -w /etc/sysconfig/network -p wa -k system-locale
auditctl -w /etc/selinux/ -p wa -k MAC-policy
auditctl -w /etc/sudoers -p wa -k scope
auditctl -w /var/log/sudo.log -p wa -k actions
# auditctl -a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
# auditctl -a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
# auditctl -a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
# auditctl -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
# auditctl -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
# auditctl -a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
# auditctl -a always,exit -F arch=b64 -S execve -F auid>=1000 -F auid!=4294967295 -k actions
# auditctl -a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>1000 -F auid!=4294967295 -k delete

# new
auditctl -a always,exit -F arch=b64 -S mount -F auid!=4294967295 -k mounts
auditctl -a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid!=4294967295 -k delete
auditctl -a always,exit -F arch=b64 -S execve -F auid!=4294967295 -k actions
auditctl -a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid!=4294967295 -k perm_mod
auditctl -a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid!=4294967295 -k perm_mod
auditctl -a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid!=4294967295 -k perm_mod
auditctl -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid!=4294967295 -k access
auditctl -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid!=4294967295 -k access
auditctl -a always,exit -F path=/etc/shadow -F perm=wa -F auid!=4294967295 -k privileged
auditctl -e 2

echo " *************** END AUDITCTL LIST *************** "