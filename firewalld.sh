#!/bin/sh

echo " *************** START FIREWALLD *************** "

yum install firewalld -y
firewall-cmd --list-all
systemctl start firewalld
systemctl status firewalld

echo " *************** END FIREWALLD *************** "