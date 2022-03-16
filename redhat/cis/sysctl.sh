#!/bin/sh

cp /etc/sysctl.conf /etc/sysctl.conf-original   # backup file

a=$(cat /etc/sysctl.conf | grep net.ipv4.ip_forward)
b=$a
c="net.ipv4.ip_forward"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.ip_forward = 0" ]
then
       echo "Change already present 12"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.secure_redirects)
b=$a
c="net.ipv4.conf.all.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.secure_redirects = 0" ]
then
       echo "Change already present 13"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.secure_redirects)
b=$a
c="net.ipv4.conf.default.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.secure_redirects = 0" ]
then
       echo "Change already present 14"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.log_martians)
b=$a
c="net.ipv4.conf.all.log_martians"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.log_martians = 1" ]
then
       echo "Change already present 15"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.log_martians)
b=$a
c="net.ipv4.conf.default.log_martians"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.log_martians = 1" ]
then
       echo "Change already present 16"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.icmp_ignore_bogus_error_responses)
b=$a
c="net.ipv4.icmp_ignore_bogus_error_responses"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]
then
       echo "Change already present 17"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.tcp_syncookies)
b=$a
c="net.ipv4.tcp_syncookies"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.tcp_syncookies = 1" ]
then
       echo "Change already present 18"
fi

sysctl -p