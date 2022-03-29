 #!/bin/bash
 
echo " *************** START AUDITCTL *************** "

  mkdir -p /opt/config_files_backup
  cp etc/audit/auditd.conf /opt/config_files_backup/auditd.conf-backup                  # auditd.conf backup
  cp /etc/audit/rules.d/audit.rules /opt/config_files_backup/audit.rules-backup         # audit.rules backup

 # Keep All Auditing Information
  echo
  echo \*\*\*\* Keep\ All\ Auditing\ Information
  egrep -q "^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$/\max_log_file_action = keep_logs\2/" /etc/audit/auditd.conf || echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf

  # Enable auditd Service
  echo
  echo \*\*\*\* Enable\ auditd\ Service
  systemctl enable auditd.service

  # Auditd file changes
  egrep -q "^(\s*)max_log_file\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)max_log_file\s*=\s*\S+(\s*#.*)?\s*$/\1max_log_file = 8\2/" /etc/audit/auditd.conf || echo "max_log_file = 8" >> /etc/audit/auditd.conf
  egrep -q "^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$/\1max_log_file_action = keep_logs\2/" /etc/audit/auditd.conf || echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf
  egrep -q "^(\s*)space_left_action\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)space_left_action\s*=\s*\S+(\s*#.*)?\s*$/\1space_left_action = EMAIL\2/" /etc/audit/auditd.conf || echo "space_left_action = EMAIL" >> /etc/audit/auditd.conf
  egrep -q "^(\s*)action_mail_acct\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)action_mail_acct\s*=\s*\S+(\s*#.*)?\s*$/\1action_mail_acct = root\2/" /etc/audit/auditd.conf || echo "action_mail_acct = root" >> /etc/audit/auditd.conf
  egrep -q "^(\s*)admin_space_left_action\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)admin_space_left_action\s*=\s*\S+(\s*#.*)?\s*$/\1admin_space_left_action = HALT\2/" /etc/audit/auditd.conf || echo "admin_space_left_action = HALT" >> /etc/audit/auditd.conf

  # Verifing & applying bit configuration 64-bit or 32-bit

    a=$(uname -p)
    b="x86_64"
    if [ "$a" == "$b" ]
    then
            bit="b64"
            echo $bit
    else
            bit="b32"
            echo $bit
    fi


  # Record Events That Modify Date and Time Information
  echo
  echo \*\*\*\* Record\ Events\ That\ Modify\ Date\ and\ Time\ Information
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+adjtimex\s+-S\s+settimeofday\s+-S\s+stime\s+-S\s+clock_settime\s+-k\s+time-change\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S adjtimex -S settimeofday -S stime -S clock_settime -k time-change" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+sethostname\s+-S\s+setdomainname\s+-S\s+system_call\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S sethostname -S setdomainname -S system_call -k system-locale" >> /etc/audit/rules.d/audit.rules

  # Record Events That Modify User/Group Information
  echo
  echo \*\*\*\* Record\ Events\ That\ Modify\ User/Group\ Information
  egrep -q "^\s*-w\s+/etc/group\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/group -p wa -k identity" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/passwd\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/gshadow\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/shadow\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/security/opasswd\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/rules.d/audit.rules

  # Record Events That Modify the System's Network Environment
  echo
  echo \*\*\*\* Record\ Events\ That\ Modify\ the\ System\'s\ Network\ Environment
  egrep -q "^\s*-w\s+/etc/issue\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/issue -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/issue.net\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/issue.net -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/hosts\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/hosts -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/sysconfig/network\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/sysconfig/network -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules

  # Record Events That Modify the System's Mandatory Access Controls
  echo
  echo \*\*\*\* Record\ Events\ That\ Modify\ the\ System\'s\ Mandatory\ Access\ Controls
  egrep -q "^\s*-w\s+/etc/selinux/\s+-p\s+wa\s+-k\s+MAC-policy\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/selinux/ -p wa -k MAC-policy" >> /etc/audit/rules.d/audit.rules

  # Collect Login and Logout Events
  echo
  echo \*\*\*\* Collect\ Login\ and\ Logout\ Events
  egrep -q "^\s*-w\s+/var/log/faillog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/faillog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/var/log/lastlog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/var/log/tallylog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/tallylog -p wa -k logins" >> /etc/audit/rules.d/audit.rules

  # Collect Session Initiation Information
  echo
  echo \*\*\*\* Collect\ Session\ Initiation\ Information
  egrep -q "^\s*-w\s+/var/run/utmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/var/log/wtmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/wtmp -p wa -k session" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/var/log/btmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/btmp -p wa -k session" >> /etc/audit/rules.d/audit.rules

  # Collect Discretionary Access Control Permission Modification Events
  echo
  echo \*\*\*\* Collect\ Discretionary\ Access\ Control\ Permission\ Modification\ Events
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+chmod\s+-S\s+fchmod\s+-S\s+fchmodat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+chown\s+-S\s+fchown\s+-S\s+fchownat\s+-S\s+lchown\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+setxattr\s+-S\s+lsetxattr\s+-S\s+fsetxattr\s+-S\s+removexattr\s+-S\s+lremovexattr\s+-S\s+fremovexattr\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules

  # Collect Unsuccessful Unauthorized Access Attempts to Files
  echo
  echo \*\*\*\* Collect\ Unsuccessful\ Unauthorized\ Access\ Attempts\ to\ Files
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EACCES\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EPERM\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/audit.rules

  # Collect Use of Privileged Commands
  echo
  echo \*\*\*\* Collect\ Use\ of\ Privileged\ Commands
  for file in `find / -xdev \( -perm -4000 -o -perm -2000 \) -type f`; do egrep -q "^\s*-a\s+(always,exit|exit,always)\s+-F\s+path=$file\s+-F\s+perm=x\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+privileged\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F path=$file -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" >> /etc/audit/rules.d/audit.rules; done

  # Collect Successful File System Mounts
  echo
  echo \*\*\*\* Collect\ Successful\ File\ System\ Mounts
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+mount\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+mounts\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >> /etc/audit/rules.d/audit.rules

  # Collect File Deletion Events by User
  echo
  echo \*\*\*\* Collect\ File\ Deletion\ Events\ by\ User
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+unlink\s+-S\s+unlinkat\s+-S\s+rename\s+-S\s+renameat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+delete\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >> /etc/audit/rules.d/audit.rules

  # Collect Changes to System Administration Scope (sudoers)
  echo
  echo \*\*\*\* Collect\ Changes\ to\ System\ Administration\ Scope\ \(sudoers\)
  egrep -q "^\s*-w\s+/etc/sudoers\s+-p\s+wa\s+-k\s+scope\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/sudoers -p wa -k scope" >> /etc/audit/rules.d/audit.rules

  # Collect System Administrator Actions (sudolog)
  echo
  echo \*\*\*\* Collect\ System\ Administrator\ Actions\ \(sudolog\)
  egrep -q "^\s*-w\s+/var/log/sudo.log\s+-p\s+wa\s+-k\s+actions\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/sudo.log -p wa -k actions" >> /etc/audit/rules.d/audit.rules

  # Collect Kernel Module Loading and Unloading
  echo
  echo \*\*\*\* Collect\ Kernel\ Module\ Loading\ and\ Unloading
  egrep -q "^\s*-w\s+/sbin/insmod\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /sbin/insmod -p x -k modules" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/sbin/rmmod\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /sbin/rmmod -p x -k modules" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/sbin/modprobe\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+init_module\s+-S\s+delete_module\s+-k\s+modules\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S init_module -S delete_module -k modules" >> /etc/audit/rules.d/audit.rules

 
 # Rest
  egrep -q "^\s*-w\s+/sbin/rmmod\s+-p\s+x\s+-k\s+module_insertion\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /sbin/rmmod -p x -k module_insertion" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/usr/bin/chmod\s+-p\s+x\s+-k\s+chmod_rule\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /usr/bin/chmod -p x -k chmod_rule" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/usr/bin/chown\s+-p\s+x\s+-k\s+chown_rule\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /usr/bin/chown -p x -k chown_rule" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/selinux\s+-p\s+wa\s+-k\s+selinux_changes\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/selinux -p wa -k selinux_changes" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/var/log/lastlog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/sudoers\s+-p\s+wa\s+-k\s+sudo_actions\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/sudoers -p wa -k sudo_actions" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-w\s+/etc/localtime\s+-p\s+wa\s+-k\s+time-change\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-w /etc/localtime -p wa -k time-change" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+sudo\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+sudo_actions\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S sudo -F auid>=1000 -F auid!=4294967295 -k sudo_actions" >> /etc/audit/rules.d/audit.rules
  egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=$bit\s+-S\s+execve\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+actions\s*(#.*)?$" /etc/audit/rules.d/audit.rules || echo "-a always,exit -F arch=$bit -S execve -F auid>=1000 -F auid!=4294967295 -k actions" >> /etc/audit/rules.d/audit.rules

  # Make the Audit Configuration Immutable
  echo
  echo \*\*\*\* Make\ the\ Audit\ Configuration\ Immutable
  sed -r '/^\s*(#.*)?$/ d' /etc/audit/rules.d/audit.rules | tail -n 1 | egrep -q "^\s*-e 2\s*(#.*)?$" || (sed '/^\s*-e 2\s*(#.*)?$/ d' /etc/audit/rules.d/audit.rules && echo "-e 2" >> /etc/audit/rules.d/audit.rules)

   # Restart auditd Service
  echo
  echo \*\*\*\* Enable\ auditd\ Service
  systemctl restart auditd.service

  echo " *************** END AUDITCTL LIST *************** "