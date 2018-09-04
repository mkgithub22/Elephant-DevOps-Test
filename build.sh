#!/bin/bash

# Test for apache installation
#   rpm shows the installed package as "httpd-version"
#   use grep -v so it won't match on httpd-tools
rpm -qa | grep "httpd" | grep -v "httpd-tools"
apacheInstalled=$?
echo "apache installed" $apacheInstalled

if test $apacheInstalled -eq 0
then
  echo "Apache already installed"
else
  sudo yum -y install httpd
  # yum return codes are not very reliable, so repeat the rpm -qa command to check for successful installation
  # Also use grep -v to ensure we don't match httpd-tools
  rpm -qa | grep "httpd" | grep -v "httpd-tools"
  apacheInstalled=$?
  if test $apacheInstalled -eq 0
  then
    echo "Apache installed"
  else
    echo "Error occurred on Apache installation.  Exiting"
    exit -1
  fi
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
  apacheStart=$?
  if test $apacheStart -eq 0
  then
    "Apache started successfully"
  else
    "Apache failed to start, return code " $apacheStart
    exit -1
  fi
fi

# test to see if our customized web page is in place
curl http://localhost | grep "Automation for the People"
ourWebPage=$?

if test $ourWebPage -eq 0
then
  echo "Our web page is set up.  All done"
else
  # most likely the default apache web site is in place
  curl http://localhost | grep "Test Page for the Apache HTTP Server"
  defaultWebPage=$?
  if test $defaultWebPage -eq 0
    then
    # create our web page and copy it to the apache folder
    echo "Default web page is set up.  Adding our index.html"
    
    # include the content for the web site here.  we could alternately copy the file from github
    echo "<html><title>Elephant DevOps Test</title><p>Automation for the People</html>" >index.html
    
    # back up the original apache web site file
    sudo mv /usr/share/httpd/noindex/index.html /usr/share/httpd/noindex/index.html.bak
    
    # put our customized web site file in place
    sudo cp index.html /usr/share/httpd/noindex/index.html
    
    # test for successful web site customization
    curl http://localhost | grep "Automation for the People"
    ourWebPage=$?
    if test $ourWebPage -eq 0
    then
      echo "Our web page is set up.  All done"
    else
      echo "Error on setting up customized web page"
      exit -1
    fi
  else
    echo "Unexpected web page result"
  fi
fi
