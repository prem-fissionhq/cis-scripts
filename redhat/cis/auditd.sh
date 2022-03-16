#!/bin/sh

cp /etc/audit/auditd.conf /tmp/auditd.conf-original

#sed -i '/max_log_file_action/s/= .*/= KEEP_LOGS/' /etc/audit/auditd.conf
#sed -i '/space_left_action/s/= .*/= EMAIL/' /etc/audit/auditd.conf
#sed -i '/admin_space_left_action/s/= .*/= HALT/' /etc/audit/auditd.conf

a=$(cat /etc/audit/auditd.conf | grep max_log_file_action)
b=$a
c="max_log_file_action"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/audit/auditd.conf
       echo "max_log_file_action = KEEP_LOGS" >> /etc/audit/auditd.conf
       echo "Config Changed"
else
       sed -i '/max_log_file_action/s/= .*/= KEEP_LOGS/' /etc/audit/auditd.conf
fi

a=$(cat /etc/audit/auditd.conf | grep space_left_action)
b=$a
c="space_left_action"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/audit/auditd.conf
       echo "space_left_action = EMAIL" >> /etc/audit/auditd.conf
       echo "Config Changed"
else
       sed -i '/space_left_action/s/= .*/= EMAIL/' /etc/audit/auditd.conf
fi

a=$(cat /etc/audit/auditd.conf | grep admin_space_left_action)
b=$a
c="admin_space_left_action"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/audit/auditd.conf
       echo "admin_space_left_action = HALT" >> /etc/audit/auditd.conf
       echo "Config Changed"
else
       sed -i '/admin_space_left_action/s/= .*/= HALT/' /etc/audit/auditd.conf
fi
