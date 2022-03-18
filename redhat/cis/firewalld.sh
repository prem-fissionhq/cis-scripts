#!/bin/sh

yum install firewalld -y
firewall-cmd --list-all
systemctl start firewalld
systemctl status firewalld
