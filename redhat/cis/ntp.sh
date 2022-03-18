#!/bin/sh

echo "Coping backupfile into /tmp directory"
cp /etc/ntp.conf /tmp/ntp.conf-original   # backupfile

a=$(cat /etc/ntp.conf | grep 'restrict default nomodify notrap nopeer noquery')
b=$a
c="restrict default nomodify notrap nopeer noquery"

if [ "$a" == "$c" ]
then
       a="#$a"   
        sed -i "/$b/ s/$b/$a/" /etc/ntp.conf # commenting existing line
        sed -i "/$a/a restrict -4 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        a="restrict -4 default kod nomodify notrap nopeer noquery"
        sed -i "/$a/a restrict -6 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        echo "Config Changed 1"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 1"
fi

a=$(cat /etc/ntp.conf | grep 'restrict -6 default kod nomodify notrap nopeer noquery')
b=$a
c="restrict -6 default kod nomodify notrap nopeer noquery"
if [ "$a" == "" ]
then
        b="restrict -4 default kod nomodify notrap nopeer noquery"
        sed -i "/$b/a restrict -6 default kod nomodify notrap nopeer noquery" /etc/ntp.conf
        echo "Config Changed 1.1"
elif [ "$a" == "$c" ]
then
         echo "Change already present 1.1"
fi
systemctl restart ntpd


a=$(cat /etc/ntp.conf | grep 'server 0.rhel.pool.ntp.org iburst')
b=$a
c="server 0.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-g.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed 2"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 2"
fi
a=$(cat /etc/ntp.conf | grep 'server 1.rhel.pool.ntp.org iburst')
b=$a
c="server 1.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-d-g.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed 3"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 3"
fi
a=$(cat /etc/ntp.conf | grep 'server 2.rhel.pool.ntp.org iburst')
b=$a
c="server 2.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-wwv.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed 4"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 4"
fi
a=$(cat /etc/ntp.conf | grep 'server 3.rhel.pool.ntp.org iburst')
b=$a
c="server 3.rhel.pool.ntp.org iburst"
if [ "$a" == "$c" ]
then
       a="#$a"
      sed -i "/$b/ s/$b/$a/" /etc/ntp.conf
      sed -i "/$a/a server time-a-b.nist.gov iburst" /etc/ntp.conf
      echo "Config Changed 5"
elif [ "$a" == "#$c" ]
then
         echo "Change already present 5"
fi
#---

a=$(grep "OPTIONS=" /etc/sysconfig/ntpd | sed -e 's/.*=//')
b=$a
c="-g"
if [ "$a" == "\"$c\"" ]
then
         a="${a//\"}"
         a="$a -u ntp:ntp"
         a="\"$a\""
         sed -i "/OPTIONS/ s/$b/$a/" /etc/sysconfig/ntpd
         echo "Config Changed 6"
elif [ "$a" == "\"-g -u ntp:ntp\"" ]
then
         echo "Change already present 6"
fi
systemctl restart ntpd
