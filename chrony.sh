#!/bin/sh

echo " *************** START CHRONY *************** "

mkdir -p /opt/config_files_backup
backupfile=$(date +'%Y_%d_%m_%H:%M')
cp /etc/chrony.conf /opt/config_files_backup/chrony.conf-${backupfile}          # chrony.conf file backup
cp /etc/sysconfig/chronyd /opt/config_files_backup/chronyd-${backupfile}       # chronyd file backup

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