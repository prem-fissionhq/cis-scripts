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
       echo "Change already present sysctl-1"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.send_redirects)
b=$a
c="net.ipv4.conf.all.send_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.send_redirects = 0" ]
then
       echo "Change already present sysctl-2"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.send_redirects)
b=$a
c="net.ipv4.conf.default.send_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.send_redirects = 0" ]
then
       echo "Change already present sysctl-3"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_source_route)
b=$a
c="net.ipv4.conf.all.accept_source_route"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.accept_source_route = 0" ]
then
       echo "Change already present sysctl-4"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_redirects)
b=$a
c="net.ipv4.conf.all.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.all.accept_redirects = 0" ]
then
       echo "Change already present sysctl-5"
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
       echo "Change already present sysctl-6"
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
       echo "Change already present sysctl-7"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_source_route)
b=$a
c="net.ipv4.conf.default.accept_source_route"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.accept_source_route = 0" ]
then
       echo "Change already present sysctl-8"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_redirects)
b=$a
c="net.ipv4.conf.default.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.conf.default.accept_redirects = 0" ]
then
       echo "Change already present sysctl-9"
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
       echo "Change already present sysctl-10"
fi
net.ipv4.conf.all.log_martians


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
       echo "Change already present sysctl-11"
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
       echo "Change already present sysctl-12"
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
       echo "Change already present sysctl-13"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.tcp_synack_retries)
b=$a
c="net.ipv4.tcp_synack_retries"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.tcp_synack_retries = 5" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv4.tcp_synack_retries = 5" ]
then
       echo "Change already present sysctl-14"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_redirects)
b=$a
c="net.ipv6.conf.all.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv6.conf.all.accept_redirects = 0" ]
then
       echo "Change already present sysctl-15"
fi

a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_redirects)
b=$a
c="net.ipv6.conf.default.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv6.conf.default.accept_redirects = 0" ]
then
       echo "Change already present sysctl-16"
fi

a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_ra)
b=$a
c="net.ipv6.conf.default.accept_ra"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv6.conf.default.accept_ra = 0" ]
then
       echo "Change already present sysctl-17"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_ra)
b=$a
c="net.ipv6.conf.all.accept_ra"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
       echo "Config Changed"
elif [ "$a" == "net.ipv6.conf.all.accept_ra = 0" ]
then
       echo "Change already present sysctl-18"
fi

sysctl -p
