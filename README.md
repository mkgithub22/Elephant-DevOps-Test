# Elephant-DevOps-Test
Automated web server setup for Elephant DevOps Test

Prerequisites:
- Create virtual Redhat 7.5 server on AWS
- Log on to the new virtual server as ec2-user, download build.sh from this project, and run it

Instructions:
- Run the build.sh script from user ec2-user's home directory as ec2-user.  
- Be sure to use "chmod +x build.sh" to make the file executable.

build.sh Process steps:
- Install Apache http server
- Start Apache
- Create customized index.html to display the "Automation for the People" web page

Cleanup:
- Stop and uninstall Apache 
   - sudo apachectl httpd stop
   - sudo yum erase httpd
   - sudo yum erase httpd-tools

Future enhancements:
- Customize Apache for better security
- Store all command outputs in a log file for better problem determination
- Create a cleanup script to "undo" all the commands and return the system to it's initial state

Change Log:
Test first - see if apache is installed
Create build.sh script, and test for installation of apache
Add step to install Apache HTTP Server

Fix test for installation, grep should search for "httpd" rather than "apache"

Add a test to see if apache is started, and if not, start it

Create the new web page in index.html
Copy the web page into the apache server folder
Test to see if it's working

Add tests to ensure successful installation

Add test to ensure apache starts successfully

Add test for web page customization successful
