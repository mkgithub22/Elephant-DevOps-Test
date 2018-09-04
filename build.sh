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
  else
    echo "Unexpected web page result"
  fi
fi
