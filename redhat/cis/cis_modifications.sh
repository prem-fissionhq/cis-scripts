#!/bin/sh

echo -e "Executing ntp configs\n"
sh ntp.sh
echo -e "Execution completed for ntp configs\n"

echo -e "\nExecuting chrony configs"
sh chrony.sh
echo -e "Execution completed for chrony configs\n"

echo -e "\nExecuting audit configs"
sh audit.sh 
echo -e "Execution completed for audit configs\n"

echo -e "\nExecuting auditd configs"
sh auditd.sh 
echo -e "Execution completed for auditd configs\n"

echo -e "\nExecuting firewalld configs"
sh firewalld.sh
echo -e "Execution completed for firewalld configs\n"

echo -e "\nExecuting pwquality configs"
sh pwquality.sh
echo -e "Execution completed for pwquality configs\n"

echo -e "\nExecuting sysctl1 configs"
sh sysctl1.sh
echo -e "Execution completed for sysctl1 configs\n"

echo -e "\nExecuting sysctl1 configs"
sh blacklist.sh
echo -e "Execution completed for blacklist configs\n"

