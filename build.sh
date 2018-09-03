#!/bin/bash

#Test for apache installation
rpm -qa | grep apache
apacheInstalled=$?
echo "apache installed" $apacheInstalled

if test $apacheInstalled -eq 0
then
  echo "Apache already installed"
else
  echo "more work to do"
fi
