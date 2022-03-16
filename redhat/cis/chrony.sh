#!/bin/sh


a=$(cat /etc/chrony.conf | grep 'server 0.rhel.pool.ntp.org iburst')
b=$a
c="server 0.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-g.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 7"
fi
a=$(cat /etc/chrony.conf | grep 'server 1.rhel.pool.ntp.org iburst')
b=$a
c="server 1.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-d-g.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 8"
fi
a=$(cat /etc/chrony.conf | grep 'server 2.rhel.pool.ntp.org iburst')
b=$a
c="server 2.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-wwv.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 9"
fi
a=$(cat /etc/chrony.conf | grep 'server 3.rhel.pool.ntp.org iburst')
b=$a
c="server 3.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
        a="#$a"
        sed -i "/$b/ s/$b/$a/" /etc/chrony.conf
        sed -i "/$a/a server time-a-b.nist.gov iburst" /etc/chrony.conf
        echo "Config Changed"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 10"
fi

a=$(grep "OPTIONS=" /etc/sysconfig/chronyd | sed -e 's/.*=//')
b=$a
if [ "$a" == "\"\"" ]
then
        a="${a//\"}"
        a="$a -u chronyd"
        a="\"$a\""
        sed -i "/OPTIONS/ s/$b/$a/" /etc/sysconfig/chronyd
        echo "Config Changed"
elif [ "$a" == "\" -u chronyd\"" ]
then
         echo "Change already present 11"
fi
