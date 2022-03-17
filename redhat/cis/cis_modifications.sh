#!/bin/sh

echo "executing ntp configs"
<pathToFile>/ntp.sh
echo "execution completed for  ntp configs"

echo "executing chrony configs"
<pathToFile>/chrony.sh
echo "execution completed for  chrony configs"
