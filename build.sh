#!/bin/bash

#Test for apache installation
rpm -qa | grep httpd
apacheInstalled=$?
echo "apache installed" $apacheInstalled

if test $apacheInstalled -eq 0
then
  echo "Apache already installed"
else
  sudo yum install httpd
fi
