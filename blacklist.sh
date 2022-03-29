#!/bin/sh

echo " *************** START BLACK LIST *************** "

mkdir -p /opt/config_files_backup
cp /etc/modprobe.d/blacklist.conf /opt/config_files_backup/blacklist.conf-backup           # blacklist.conf file backup

if [ ! -e /etc/modprobe.d/blacklist.conf ]; then
    mkdir -p /etc/modprobe.d
    touch /etc/modprobe.d/blacklist.conf
fi                                                      # verifing/creating file

cp /etc/modprobe.d/blacklist.conf /tmp/blacklist.conf-original

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install cramfs /bin/true")
b=$a
c="install cramfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install cramfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install freevxfs /bin/true")
b=$a
c="install freevxfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install freevxfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install jffs2 /bin/true")
b=$a
c="install jffs2 /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install jffs2 /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfs /bin/true")
b=$a
c="install hfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install hfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install hfsplus /bin/true")
b=$a
c="install hfsplus /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install hfsplus /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install squashfs /bin/true")
b=$a
c="install squashfs /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install squashfs /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install udf /bin/true")
b=$a
c="install udf /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install udf /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

a=$(cat /etc/modprobe.d/blacklist.conf | grep "install usb-storage /bin/true")
b=$a
c="install usb-storage /bin/true"
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/modprobe.d/blacklist.conf
       echo "install usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf
       echo "Config Changed"
else
       echo "Alredy satisfied"
fi

#echo -e "install cramfs /bin/true\ninstall freevxfs /bin/true\ninstall jffs2 /bin/true\ninstall hfs /bin/true\ninstall hfsplus /bin/true\ninstall squashfs /bin/true\ninstall udf /bin/true\ninstall usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf

echo " *************** END BLACK LIST *************** "