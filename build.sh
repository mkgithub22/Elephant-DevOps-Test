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
  # todo: also need a step here to ensure the install was successful
fi

sudo apachectl status | grep "Active: active"
apacheStarted=$?
echo "apache started " $apacheStarted

if test $apacheStarted -eq 0
then
  echo "Apache is running"
else
  echo "Apache not running, starting"
  sudo apachectl start
  # todo: check return code
fi

