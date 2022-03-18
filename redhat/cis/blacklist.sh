#!/bin/sh

if [ ! -e /etc/modprobe.d/blacklist.conf ]; then
    mkdir -p /etc/modprobe.d
    touch /etc/modprobe.d/blacklist.conf
fi                                                      # verifing/creating file

echo "Coping backupfile into /tmp directory"
cp /etc/modprobe.d/blacklist.conf /tmp/blacklist.conf-original	# backup file

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install cramfs /bin/true")
b=$a
c="install cramfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install cramfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 1"
else
       echo "Alredy satisfied 1"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install freevxfs /bin/true")
b=$a
c="install freevxfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install freevxfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 2"
else
       echo "Alredy satisfied 2"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install jffs2 /bin/true")
b=$a
c="install jffs2 /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install jffs2 /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 3"
else
       echo "Alredy satisfied 3"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfs /bin/true")
b=$a
c="install hfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install hfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 4"
else
       echo "Alredy satisfied 4"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfsplus /bin/true")
b=$a
c="install hfsplus /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install hfsplus /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 5"
else
       echo "Alredy satisfied 5"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install squashfs /bin/true")
b=$a
c="install squashfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install squashfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 6"
else
       echo "Alredy satisfied 6"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install udf /bin/true")
b=$a
c="install udf /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install udf /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 7"
else
       echo "Alredy satisfied 7"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install usb-storage /bin/true")
b=$a
c="install usb-storage /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed 8"
else
       echo "Alredy satisfied 8"
fi

