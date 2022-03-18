#!/bin/sh

echo "Coping backupfile into /tmp directory"
cp /etc/sysctl.conf /etc/sysctl.conf-original   # backup file

a=$(cat /etc/sysctl.conf | grep net.ipv4.ip_forward)
b=$a
c="net.ipv4.ip_forward"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
       echo "Config Changed 1"
elif [ "$a" == "net.ipv4.ip_forward = 0" ]
then
       echo "Change already present 1"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.send_redirects)
b=$a
c="net.ipv4.conf.all.send_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 2"
elif [ "$a" == "net.ipv4.conf.all.send_redirects = 0" ]
then
       echo "Change already present 2"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.send_redirects)
b=$a
c="net.ipv4.conf.default.send_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 3"
elif [ "$a" == "net.ipv4.conf.default.send_redirects = 0" ]
then
       echo "Change already present 3"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_source_route)
b=$a
c="net.ipv4.conf.all.accept_source_route"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
       echo "Config Changed 4"
elif [ "$a" == "net.ipv4.conf.all.accept_source_route = 0" ]
then
       echo "Change already present 4"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_redirects)
b=$a
c="net.ipv4.conf.all.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 5"
elif [ "$a" == "net.ipv4.conf.all.accept_redirects = 0" ]
then
       echo "Change already present 5"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.secure_redirects)
b=$a
c="net.ipv4.conf.all.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 6"
elif [ "$a" == "net.ipv4.conf.all.secure_redirects = 0" ]
then
       echo "Change already present 6"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.all.log_martians)
b=$a
c="net.ipv4.conf.all.log_martians"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
       echo "Config Changed 7"
elif [ "$a" == "net.ipv4.conf.all.log_martians = 1" ]
then
       echo "Change already present 7"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_source_route)
b=$a
c="net.ipv4.conf.default.accept_source_route"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
       echo "Config Changed 8"
elif [ "$a" == "net.ipv4.conf.default.accept_source_route = 0" ]
then
       echo "Change already present 8"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_redirects)
b=$a
c="net.ipv4.conf.default.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 9"
elif [ "$a" == "net.ipv4.conf.default.accept_redirects = 0" ]
then
       echo "Change already present 9"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.conf.default.secure_redirects)
b=$a
c="net.ipv4.conf.default.secure_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 10"
elif [ "$a" == "net.ipv4.conf.default.secure_redirects = 0" ]
then
       echo "Change already present 10"
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
       echo "Config Changed 11"
elif [ "$a" == "net.ipv4.conf.default.log_martians = 1" ]
then
       echo "Change already present 11"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.icmp_ignore_bogus_error_responses)
b=$a
c="net.ipv4.icmp_ignore_bogus_error_responses"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
       echo "Config Changed 12"
elif [ "$a" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]
then
       echo "Change already present 12"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.tcp_syncookies)
b=$a
c="net.ipv4.tcp_syncookies"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
       echo "Config Changed 13"
elif [ "$a" == "net.ipv4.tcp_syncookies = 1" ]
then
       echo "Change already present 13"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv4.tcp_synack_retries)
b=$a
c="net.ipv4.tcp_synack_retries"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv4.tcp_synack_retries = 5" >> /etc/sysctl.conf
       echo "Config Changed 14"
elif [ "$a" == "net.ipv4.tcp_synack_retries = 5" ]
then
       echo "Change already present 14"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_redirects)
b=$a
c="net.ipv6.conf.all.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 15"
elif [ "$a" == "net.ipv6.conf.all.accept_redirects = 0" ]
then
       echo "Change already present 15"
fi

a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_redirects)
b=$a
c="net.ipv6.conf.default.accept_redirects"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
       echo "Config Changed 16"
elif [ "$a" == "net.ipv6.conf.default.accept_redirects = 0" ]
then
       echo "Change already present 16"
fi

a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_ra)
b=$a
c="net.ipv6.conf.default.accept_ra"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
       echo "Config Changed 17"
elif [ "$a" == "net.ipv6.conf.default.accept_ra = 0" ]
then
       echo "Change already present 17"
fi
a=$(cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_ra)
b=$a
c="net.ipv6.conf.all.accept_ra"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/sysctl.conf
       echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
       echo "Config Changed 18"
elif [ "$a" == "net.ipv6.conf.all.accept_ra = 0" ]
then
       echo "Change already present 18"
fi

sysctl -p
