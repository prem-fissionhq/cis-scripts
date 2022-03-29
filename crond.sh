#!/bin/bash

echo " *************** START CROND *************** "

# Enable anacron Daemon
  echo
  echo \*\*\*\* Enable\ anacron\ Daemon
  rpm -q cronie-anacron || yum -y install cronie-anacron

  # Enable crond Daemon
  echo
  echo \*\*\*\* Enable\ crond\ Daemon
  systemctl enable crond.service

  # Set User/Group Owner and Permission on /etc/anacrontab
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/anacrontab
  chmod g-r-w-x,o-r-w-x /etc/anacrontab
  chown 0:0 /etc/anacrontab

  # Set User/Group Owner and Permission on /etc/crontab
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/crontab
  chmod g-r-w-x,o-r-w-x /etc/crontab
  chown 0:0 /etc/crontab

  # Set User/Group Owner and Permission on /etc/cron.hourly
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.hourly
  chmod g-r-w-x,o-r-w-x /etc/cron.hourly/
  chown 0:0 /etc/cron.hourly/

  # Set User/Group Owner and Permission on /etc/cron.daily
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.daily
  chmod g-r-w-x,o-r-w-x /etc/cron.daily/
  chown 0:0 /etc/cron.daily/

  # Set User/Group Owner and Permission on /etc/cron.weekly
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.weekly
  chmod g-r-w-x,o-r-w-x /etc/cron.weekly/
  chown 0:0 /etc/cron.weekly/

  # Set User/Group Owner and Permission on /etc/cron.monthly
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.monthly
  chmod g-r-w-x,o-r-w-x /etc/cron.monthly/
  chown 0:0 /etc/cron.monthly/

  # Set User/Group Owner and Permission on /etc/cron.d
  echo
  echo \*\*\*\* Set\ User/Group\ Owner\ and\ Permission\ on\ /etc/cron.d
  chmod g-r-w-x,o-r-w-x /etc/cron.d/
  chown 0:0 /etc/cron.d/

  # Restrict at Daemon
  echo
  echo \*\*\*\* Restrict\ at\ Daemon
  rm -rf /etc/at.deny
  touch /etc/at.allow
  chmod g-r-w-x,o-r-w-x /etc/at.allow
  chown 0:0 /etc/at.allow

  # Restrict at/cron to Authorized Users
  echo
  echo \*\*\*\* Restrict\ at/cron\ to\ Authorized\ Users
  rm -rf /etc/cron.deny
  touch /etc/cron.allow
  chmod g-r-w-x,o-r-w-x /etc/cron.allow
  chown 0:0 /etc/cron.allow

  echo " *************** END CROND *************** "