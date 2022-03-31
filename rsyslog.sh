#!/bin/bash

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