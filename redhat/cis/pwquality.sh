#!/bin/sh

echo "Coping backupfile into /tmp directory"
cp /etc/security/pwquality.conf /tmp/pwquality.conf-original	# backup file

a=$(cat /etc/security/pwquality.conf | grep 'minlen')
b=$a
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/security/pwquality.conf
       echo "minlen = 12" >> /etc/security/pwquality.conf
       echo "Config inserted 1"
else
       sed '/minlen/s/^# //' -i /etc/security/pwquality.conf
       sed -i '/minlen/s/= .*/= 12/' /etc/security/pwquality.conf 
       echo "Config updated 1"
fi

a=$(cat /etc/security/pwquality.conf | grep 'minclass')
b=$a
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/security/pwquality.conf
       echo "minclass = 4" >> /etc/security/pwquality.conf
       echo "Config inserted 2"
else
       sed '/minclass/s/^# //' -i /etc/security/pwquality.conf
       sed -i '/minclass/s/= .*/= 4/' /etc/security/pwquality.conf 
       echo "Config updated 2"
fi

a=$(cat /etc/security/pwquality.conf | grep 'dcredit')
b=$a
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/security/pwquality.conf
       echo "dcredit = -1" >> /etc/security/pwquality.conf
       echo "Config inserted 3"
else
       sed '/dcredit/s/^# //' -i /etc/security/pwquality.conf
       sed -i '/dcredit/s/= .*/= -1/' /etc/security/pwquality.conf 
       echo "Config updated 3"
fi

a=$(cat /etc/security/pwquality.conf | grep 'ucredit')
b=$a
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/security/pwquality.conf
       echo "ucredit = -1" >> /etc/security/pwquality.conf
       echo "Config inserted 4"
else
       sed '/ucredit/s/^# //' -i /etc/security/pwquality.conf
       sed -i '/ucredit/s/= .*/= -1/' /etc/security/pwquality.conf 
       echo "Config updated 4"
fi

a=$(cat /etc/security/pwquality.conf | grep 'lcredit')
b=$a
if [ "$a" == "" ]
then
       a="#$a"
       sed -i "/$b/ s/$b/$a/" /etc/security/pwquality.conf
       echo "lcredit = -1" >> /etc/security/pwquality.conf
       echo "Config inserted 5"
else
       sed '/lcredit/s/^# //' -i /etc/security/pwquality.conf
       sed -i '/lcredit/s/= .*/= -1/' /etc/security/pwquality.conf 
       echo "Config updated 5"
fi
