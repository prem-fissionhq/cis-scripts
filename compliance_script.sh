#!/bin/bash
 
echo " *************** START NTP *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/ntp.conf /opt/config_files_backup/ntp.conf-${backupfile}             # ntp.conf file backup
    cp /etc/sysconfig/ntpd /opt/config_files_backup/ntpd-${backupfile}           # ntpd file backup

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

echo " *************** START CHRONY *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/chrony.conf /opt/config_files_backup/chrony.conf-${backupfile}         # chrony.conf file backup
    cp /etc/sysconfig/chronyd //opt/config_files_backup/chronyd-${backupfile}      # chronyd file backup

    a=$(cat /etc/chrony.conf | grep 'server 0.rhel.pool.ntp.org iburst')
    b=$a
    c="server 0.rhel.pool.ntp.org iburst"
    if [ "$a" == "$c" ]
    then
            a="#$a"
            sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
            sed -i "/$a/a server time-a-g.nist.gov iburst" /etc/chrony.conf
            echo "Config Changed 1"
    elif [ "$a" == "#$c" ]
    then
            echo "Change already present 1"
    fi
    a=$(cat /etc/chrony.conf | grep 'server 1.rhel.pool.ntp.org iburst')
    b=$a
    c="server 1.rhel.pool.ntp.org iburst"
    if [ "$a" == "$c" ]
    then
            a="#$a"
            sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
            sed -i "/$a/a server time-d-g.nist.gov iburst" /etc/chrony.conf
            echo "Config Changed 2"
    elif [ "$a" == "#$c" ]
    then
            echo "Change already present 2"
    fi
    a=$(cat /etc/chrony.conf | grep 'server 2.rhel.pool.ntp.org iburst')
    b=$a
    c="server 2.rhel.pool.ntp.org iburst"
    if [ "$a" == "$c" ]
    then
            a="#$a"
            sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
            sed -i "/$a/a server time-a-wwv.nist.gov iburst" /etc/chrony.conf
            echo "Config Changed 3"
    elif [ "$a" == "#$c" ]
    then
            echo "Change already present 3"
    fi
    a=$(cat /etc/chrony.conf | grep 'server 3.rhel.pool.ntp.org iburst')
    b=$a
    c="server 3.rhel.pool.ntp.org iburst"
    if [ "$a" == "$c" ]
    then
            a="#$a"
            sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
            sed -i "/$a/a server time-a-b.nist.gov iburst" /etc/chrony.conf
            echo "Config Changed 4"
    elif [ "$a" == "#$c" ]
    then
            echo "Change already present 4"
    fi

    a=$(grep "OPTIONS=" /etc/sysconfig/chronyd | sed -e 's/.*=//')
    b=$a
    if [ "$a" == "\"\"" ]
    then
            a="${a//\"}"
            a="$a -u chronyd"
            a="\"$a\""
            sed -i "/OPTIONS/ s/$b/$a/" /etc/sysconfig/chronyd
            echo "Config Changed 5"
    elif [ "$a" == "\" -u chronyd\"" ]
    then
            echo "Change already present 5"
    fi

echo " *************** END CHRONY *************** "

echo " *************** START AUDITCTL *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp etc/audit/auditd.conf /opt/config_files_backup/auditd.conf-${backupfile}                  # auditd.conf backup
    cp /etc/audit/rules.d/audit.rules /opt/config_files_backup/audit.rules-${backupfile}         # audit.rules backup

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

echo " *************** END AUDITCTL *************** "

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

echo " *************** START BLACK LIST *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/modprobe.d/blacklist.conf /opt/config_files_backup/blacklist.conf-${backupfile}           # blacklist.conf file backup

    if [ ! -e /etc/modprobe.d/blacklist.conf ]; then
        mkdir -p /etc/modprobe.d
        touch /etc/modprobe.d/blacklist.conf
    fi                                                      # verifing/creating file

    cp /etc/modprobe.d/blacklist.conf /tmp/blacklist.conf-original

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install cramfs /bin/true")
    b=$a
    c="install cramfs /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install cramfs /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install freevxfs /bin/true")
    b=$a
    c="install freevxfs /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install freevxfs /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install jffs2 /bin/true")
    b=$a
    c="install jffs2 /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install jffs2 /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfs /bin/true")
    b=$a
    c="install hfs /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install hfs /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfsplus /bin/true")
    b=$a
    c="install hfsplus /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install hfsplus /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install squashfs /bin/true")
    b=$a
    c="install squashfs /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install squashfs /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install udf /bin/true")
    b=$a
    c="install udf /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install udf /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    a=$(cat /etc/modprobe.d/blacklist.conf | grep "install usb-storage /bin/true")
    b=$a
    c="install usb-storage /bin/true"
    if [ "$a" == "" ]
    then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
        echo "install usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf
        echo "Config Changed"
    else
        echo "Alredy satisfied"
    fi

    #echo -e "install cramfs /bin/true\ninstall freevxfs /bin/true\ninstall jffs2 /bin/true\ninstall hfs /bin/true\ninstall hfsplus /bin/true\ninstall squashfs /bin/true\ninstall udf /bin/true\ninstall usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf

echo " *************** END BLACK LIST *************** "

echo " *************** START COREDUMP *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/systemd/coredump.conf opt/config_files_backup/coredump.conf-${backupfile}      # coredump.conf file backup

    egrep -q "^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/coredump.conf && sed -ri "s/^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$/\Storage=none\2/" /etc/systemd/coredump.conf || echo "Storage=none" >> /etc/systemd/coredump.conf
    egrep -q "^(\s*)ProcessSizeMax\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/coredump.conf && sed -ri "s/^(\s*)ProcessSizeMax\s*=\s*\S+(\s*#.*)?\s*$/\ProcessSizeMax=0\2/" /etc/systemd/coredump.conf || echo "ProcessSizeMax=0" >> /etc/systemd/coredump.conf

echo " *************** END COREDUMP *************** "

echo " *************** START CROND *************** "

    # Enable anacron Daemon
    echo
    echo \*\*\*\* Enable\ anacron\ Daemon
    rpm -q cronie-anacron || yum -y install cronie-anacron

    # Enable crond Daemon
    echo
    echo \*\*\*\* Enable\ crond\ Daemon
    systemctl enable crond.service

    # Set User/Group Owner and Permission on /etc/anacrontab
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/anacrontab
    chmod g-r-w-x,o-r-w-x /etc/anacrontab
    chown 0:0 /etc/anacrontab

    # Set User/Group Owner and Permission on /etc/crontab
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/crontab
    chmod g-r-w-x,o-r-w-x /etc/crontab
    chown 0:0 /etc/crontab

    # Set User/Group Owner and Permission on /etc/cron.hourly
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.hourly
    chmod g-r-w-x,o-r-w-x /etc/cron.hourly/
    chown 0:0 /etc/cron.hourly/

    # Set User/Group Owner and Permission on /etc/cron.daily
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.daily
    chmod g-r-w-x,o-r-w-x /etc/cron.daily/
    chown 0:0 /etc/cron.daily/

    # Set User/Group Owner and Permission on /etc/cron.weekly
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.weekly
    chmod g-r-w-x,o-r-w-x /etc/cron.weekly/
    chown 0:0 /etc/cron.weekly/

    # Set User/Group Owner and Permission on /etc/cron.monthly
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.monthly
    chmod g-r-w-x,o-r-w-x /etc/cron.monthly/
    chown 0:0 /etc/cron.monthly/

    # Set User/Group Owner and Permission on /etc/cron.d
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.d
    chmod g-r-w-x,o-r-w-x /etc/cron.d/
    chown 0:0 /etc/cron.d/

    # Restrict at Daemon
    echo
    echo \*\*\*\* Restrict\ at\ Daemon
    rm -rf /etc/at.deny
    touch /etc/at.allow
    chmod g-r-w-x,o-r-w-x /etc/at.allow
    chown 0:0 /etc/at.allow

    # Restrict at/cron to Authorized Users
    echo
    echo \*\*\*\* Restrict\ at/cron\ to\ Authorized\ Users
    rm -rf /etc/cron.deny
    touch /etc/cron.allow
    chmod g-r-w-x,o-r-w-x /etc/cron.allow
    chown 0:0 /etc/cron.allow

echo " *************** END CROND *************** "

echo " *************** START FIREWALLD *************** "

    yum install firewalld -y
    firewall-cmd --list-all
    systemctl start firewalld
    systemctl status firewalld

echo " *************** END FIREWALLD *************** "

echo " *************** START grub *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /boot/grub2/grub.cfg /opt/config_files_backup/grub.cfg-${backupfile}      # grub.cfg file backup

    # Set User/Group Owner on /boot/grub2/grub.cfg
    echo
    echo \*\*\*\* Set\ User/Group\ Owner\ on\ /boot/grub2/grub.cfg
    chown 0:0 /boot/grub2/grub.cfg

    # Set Permissions on /boot/grub2/grub.cfg
    echo
    echo \*\*\*\* Set\ Permissions\ on\ /boot/grub2/grub.cfg
    chmod g-r-w-x,o-r-w-x /boot/grub2/grub.cfg

    # Enable Auditing for Processes That Start Prior to auditd
    echo
    echo \*\*\*\* Enable\ Auditing\ for\ Processes\ That\ Start\ Prior\ to\ auditd
    egrep -q "^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?\"(\s*#.*)?\s*$" /etc/default/grub && sed -ri '/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]*)?\"(\s*#.*)?\s*$/ {/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?audit=\S+(\s+[^\"]+)?\"(\s*#.*)?\s*$/! s/^(\s*GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?)(\"(\s*#.*)?\s*)$/\1 audit=1\3/ }' /etc/default/grub && sed -ri "s/^((\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?)audit=\S+((\s+[^\"]+)?\"(\s*#.*)?\s*)$/\1audit=1\4/" /etc/default/grub || echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >> /etc/default/grub
    grub2-mkconfig -o /boot/grub2/grub.cfg

    #egrep -q "^(\s*)selinux\s*=\s*\S+(\s*#.*)?\s*$" /boot/grub2/grub.cfg && sed -ri "s/^(\s*)selinux\s*=\s*\S+(\s*#.*)?\s*$/\selinux=0\2/" /boot/grub2/grub.cfg || echo "selinux=0" >> /boot/grub2/grub.cfg

echo " *************** END grub *************** "

echo " *************** START JOURNALD *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/systemd/journald.conf /opt/config_files_backup/journald.conf-${backupfile}         # journald.conf file backup

    egrep -q "^(\s*)ForwardToSyslog\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)ForwardToSyslog\s*=\s*\S+(\s*#.*)?\s*$/\1ForwardToSyslog=yes\2/" /etc/systemd/journald.conf || echo "ForwardToSyslog=yes" >> /etc/systemd/journald.conf
    egrep -q "^(\s*)Compress\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)Compress\s*=\s*\S+(\s*#.*)?\s*$/\1Compress=yes\2/" /etc/systemd/journald.conf || echo "Compress=yes" >> /etc/systemd/journald.conf
    egrep -q "^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$" /etc/systemd/journald.conf && sed -ri "s/^(\s*)Storage\s*=\s*\S+(\s*#.*)?\s*$/\1Storage=persistent\2/" /etc/systemd/journald.conf || echo "Storage=persistent" >> /etc/systemd/journald.conf

echo " *************** END JOURNALD *************** "

echo " *************** START LOGIN *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/login.defs /opt/config_files_backup/login.defs-${backupfile}       # login.defsfile backup

    # Set  Expiration Days
    echo
    echo \*\*\*\* Set\ Password\ Expiration\ Days
    egrep -q "^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MAX_DAYS 364\2/" /etc/login.defs || echo "PASS_MAX_DAYS 364" >> /etc/login.defs
    #getent passwd | cut -d ':' -f 1 | xargs -n1 chage --maxdays 364

    # Set Password Change Minimum Number of Days
    echo
    echo \*\*\*\* Set\ Password\ Change\ Minimum\ Number\ of\ Days
    egrep -q "^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MIN_DAYS 90\2/" /etc/login.defs || echo "PASS_MIN_DAYS 90" >> /etc/login.defs
    #getent passwd | cut -d ':' -f 1 | xargs -n1 chage --mindays 90

    # Set Password Expiring Warning Days
    echo
    echo \*\*\*\* Set\ Password\ Expiring\ Warning\ Days
    egrep -q "^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$/\PASS_WARN_AGE 7\2/" /etc/login.defs || echo "PASS_WARN_AGE 7" >> /etc/login.defs
    #getent passwd | cut -d ':' -f 1 | xargs -n1 chage --warndays 7

 echo " *************** END LOGIN *************** "

echo " *************** START PWQUALITY *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/bashrc /opt/config_files_backup/bashrc-${backupfile}                       # bashrc file backup
    cp /etc/security/pwquality.conf /opt/config_files_backup/pwquality.conf-${backupfile}  # pwquality.conf file backup
    cp /etc/profile /opt/config_files_backup/profile-${backupfile}                     # profile file backup
    cp /etc/selinux/config /opt/config_files_backup/selinux-config-${backupfile}       # selinux-config file backup

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
    

    # # Disable System Accounts
    # echo
    # echo \*\*\*\* Disable\ System\ Accounts
    # for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd`; do
    #     if [ $user != "root" ]
    #     then
    #     /usr/sbin/usermod -L $user
    #     if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]
    #     then
    #         /usr/sbin/usermod -s /sbin/nologin $user
    #     fi
    #     fi
    # done


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
    useradd -D -f 30

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

echo " *************** START RSYSLOG *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/rsyslog.conf /opt/config_files_backup/rsyslog.conf-${backupfile}     # rsyslog.conf file backup

    # Install the rsyslog package
    echo
    echo \*\*\*\* Install\ the\ rsyslog\ package
    rpm -q rsyslog || yum -y install rsyslog

    # Activate the rsyslog Service
    echo
    echo \*\*\*\* Activate\ the\ rsyslog\ Service
    systemctl enable rsyslog

    # Changing Permissions
    a=$(cat /etc/rsyslog.conf | grep '$FileCreateMode 0640')
    c='$FileCreateMode 0640'
    if [ "$a" != "$c" ]
    then
            echo '$FileCreateMode 0640' >> /etc/rsyslog.conf
            echo "Updated 1"
    elif [ "$a" == "$c" ]
    then
            echo "Change already present 1"
    fi

echo " *************** END RSYSLOG *************** "

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

echo " *************** END SSHD *************** "

echo " *************** START SUDOERS *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/sudoers /opt/config_files_backup/sudoers-${backupfile}       # sudoers file backup
    cp /etc/yum.conf /opt/config_files_backup/yum.conf-${backupfile}       # yum.conf file backup

    # Installing sudo
    yum install sudo

    a=$(cat /etc/sudoers | grep 'Defaults    use_pty')
    c="Defaults    use_pty"
    if [ "$a" != "$c" ]
    then
            echo "Defaults    use_pty" >> /etc/sudoers
            echo "Updated"
    else
            echo "Change already present"
    fi

    a=$(cat /etc/sudoers | grep 'Defaults    logfile="/var/log/sudo.log"')
    c='Defaults    logfile="/var/log/sudo.log"'
    if [ "$a" != "$c" ]
    then
            echo 'Defaults    logfile="/var/log/sudo.log"' >> /etc/sudoers
            echo "Updated 2"
    elif [ "$a" == "$c" ]
    then
            echo "Change already present 2"
    fi

    egrep -q "^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$" /etc/yum.conf && sed -ri "s/^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$/\gpgcheck=1\2/" /etc/yum.conf || echo "gpgcheck=1" >> /etc/yum.conf

echo " *************** END SUDOERS *************** "

echo " *************** START SYSCTL *************** "

    mkdir -p /opt/config_files_backup
    backupfile=$(date +'%Y_%d_%m_%H:%M')
    cp /etc/sysctl.conf /opt/config_files_backup/sysctl.conf-${backupfile}     # sysctl.conf file backup

    # Restrict Core Dumps
    echo
    echo \*\*\*\* Restrict\ Core\ Dumps
    egrep -q "^(\s*)\*\s+hard\s+core\s+\S+(\s*#.*)?\s*$" /etc/security/limits.conf && sed -ri "s/^(\s*)\*\s+hard\s+core\s+\S+(\s*#.*)?\s*$/\1* hard core 0\2/" /etc/security/limits.conf || echo "* hard core 0" >> /etc/security/limits.conf
    egrep -q "^(\s*)fs.suid_dumpable\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)fs.suid_dumpable\s*=\s*\S+(\s*#.*)?\s*$/\1fs.suid_dumpable = 0\2/" /etc/sysctl.conf || echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf

    # Enable Randomized Virtual Memory Region Placement
    echo
    echo \*\*\*\* Enable\ Randomized\ Virtual\ Memory\ Region\ Placement
    egrep -q "^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$/\1kernel.randomize_va_space = 2\2/" /etc/sysctl.conf || echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

    # Enable Randomized Virtual Memory Region Placement
    echo
    echo \*\*\*\* Enable\ Randomized\ Virtual\ Memory\ Region\ Placement
    egrep -q "^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$/\1kernel.randomize_va_space = 2\2/" /etc/sysctl.conf || echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

    # Disable IP Forwarding
    
    echo
    echo \*\*\*\* Disable\ IP\ Forwarding
    egrep -q "^(\s*)net.ipv4.ip_forward\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.ip_forward\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.ip_forward = 0\2/" /etc/sysctl.conf || echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf

    # Disable Send Packet Redirects
    echo
    echo \*\*\*\* Disable\ Send\ Packet\ Redirects
    egrep -q "^(\s*)net.ipv4.conf.all.send_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.send_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.send_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.default.send_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.send_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.send_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf

    # Disable Source Routed Packet Acceptance
    echo
    echo \*\*\*\* Disable\ Source\ Routed\ Packet\ Acceptance
    egrep -q "^(\s*)net.ipv4.conf.all.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.accept_source_route = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.default.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.accept_source_route = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf

    # Disable ICMP Redirect Acceptance
    echo
    echo \*\*\*\* Disable\ ICMP\ Redirect\ Acceptance
    egrep -q "^(\s*)net.ipv4.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf

    egrep -q "^(\s*)net.ipv4.conf.all.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.secure_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.default.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.secure_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf

    # Log Suspicious Packets
    echo
    echo \*\*\*\* Log\ Suspicious\ Packets
    egrep -q "^(\s*)net.ipv4.conf.all.log_martians\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.log_martians\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.log_martians = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.default.log_martians\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.log_martians\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.log_martians = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf

    # Enable Ignore Broadcast Requests
    echo
    echo \*\*\*\* Enable\ Ignore\ Broadcast\ Requests
    egrep -q "^(\s*)net.ipv4.icmp_echo_ignore_broadcasts\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.icmp_echo_ignore_broadcasts\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.icmp_echo_ignore_broadcasts = 1\2/" /etc/sysctl.conf || echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf

    # Enable Bad Error Message Protection
    echo
    echo \*\*\*\* Enable\ Bad\ Error\ Message\ Protection
    egrep -q "^(\s*)net.ipv4.icmp_ignore_bogus_error_responses\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.icmp_ignore_bogus_error_responses\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.icmp_ignore_bogus_error_responses = 1\2/" /etc/sysctl.conf || echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf

    # Enable TCP SYN Cookies
    echo
    echo \*\*\*\* Enable\ TCP\ SYN\ Cookies
    egrep -q "^(\s*)net.ipv4.tcp_syncookies\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.tcp_syncookies\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.tcp_syncookies = 1\2/" /etc/sysctl.conf || echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf

    egrep -q "^(\s*)net.ipv4.tcp_synack_retries\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.tcp_synack_retries\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.tcp_synack_retries = 5\2/" /etc/sysctl.conf || echo "net.ipv4.tcp_synack_retries = 5" >> /etc/sysctl.conf

    egrep -q "^(\s*)net.ipv4.conf.default.rp_filter\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.rp_filter\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.rp_filter = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv4.conf.all.rp_filter\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.rp_filter\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.rp_filter = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
    

    # IPV6 Disable ICMP Redirect Acceptance
    echo
    echo \*\*\*\* Disable\ ICMP\ Redirect\ Acceptance
    egrep -q "^(\s*)net.ipv6.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv6.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv6.conf.all.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv6.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv6.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv6.conf.default.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf

    egrep -q "^(\s*)net.ipv6.conf.default.accept_ra\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv6.conf.default.accept_ra\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv6.conf.default.accept_ra = 0\2/" /etc/sysctl.conf || echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
    egrep -q "^(\s*)net.ipv6.conf.all.accept_ra\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv6.conf.all.accept_ra\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv6.conf.all.accept_ra = 0\2/" /etc/sysctl.conf || echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf


        # Enable Randomized Virtual Memory Region Placement
    echo
    echo \*\*\*\* Enable\ Randomized\ Virtual\ Memory\ Region\ Placement
    egrep -q "^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$/\1kernel.randomize_va_space = 2\2/" /etc/sysctl.conf || echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

echo " *************** END SYSCTL *************** "
