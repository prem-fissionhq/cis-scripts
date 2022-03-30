#!/bin/bash

echo " *************** START SUDOERS *************** "

        mkdir -p /opt/config_files_backup
        backupfile=$(date +'%Y_%d_%m_%H:%M')
        cp /etc/sudoers /opt/config_files_backup/sudoers-${backupfile}                # sudoers file backup
        cp /etc/yum.conf /opt/config_files_backup/yum.conf-${backupfile}              # yum.conf file backup

        # Installing sudo
        yum install sudo -y

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