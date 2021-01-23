#!/bin/bash
: <<'COMMENT'
VM: 20 GB Disk 5GB RAM.
Brand new Ubuntu 20.04 VM - nothing installed.
This setup is to work on a php webpage using apache server and Remote MySQL DB on AWS RDS.

Having to create a VirtualBox Ubuntu image again due to the first one crashing.
This script is to streamline the needed programs and config set up incase i need to make a new one. 
(working on dockerizing project soon for ease)

We will also need git to store our work remotely for safe keeping.
** Haris Nasir 1/22/21**
COMMENT

# Update system
echo -e "-------------\n-------------"
echo "Updating..."
echo -e "-------------\n-------------"
sleep 3
sudo apt-get update

# Get VIM: vi arrow keys and backspace may not work.
# If downloading vim doesn't fix this, do following:
# vi $HOME/.exrc
# add the line: set nocompatible
echo -e "-------------\n-------------"
echo "Installing VIM..."
echo -e "-------------\n-------------"
sleep 3
sudo apt-get install vim

echo -e "-------------\n-------------"
echo "Installing essential dkms..."
echo -e "-------------\n-------------"
sleep 3
# VM screen may not go into full screen.
sudo apt-get install build-essential dkms linux-headers-$(uname -r)
# Now click Devices in VirtualBox window
# Click Insert Guest Additions coimage
# click Run
# Restart VM

echo -e "-------------\n-------------"
echo "Installing apache2..."
echo -e "-------------\n-------------"
sleep 3
sudo apt-get update
sudo apt-get install apache2

# Website content go's in /var/www/
echo -e "-------------\n-------------"
echo -e "Making new site called ott in /var/www ...\nPlace all your html,css files here"
echo -e "-------------\n-------------"
sleep 3
cd /var/www/
sudo cp -r html ott

# Make sample index.html and move into /var/www/ott but Delete all from /var/www/ott before moving. 
echo -e "-------------\n-------------"
echo -e "Making sample index.html..."
echo -e "-------------\n-------------"
sleep 3
touch index.html
cat > index.html <<EOF
<html>
<h1>My sample web page</h1>
</html>
EOF

echo -e "-------------\n-------------"
echo -e "Removing all html files from /var/www/ott ..."
echo -e "-------------\n-------------"
sleep 3
sudo rm /var/www/ott/*.html

echo -e "-------------\n-------------"
echo -e "Moving sample html file to /var/www/ott ..."
echo -e "-------------\n-------------"
sleep 3
sudo mv ./index.html /var/www/ott

# Website's Apache config files are in /etc/apache2/sites-available
# Important information you want in 001-ott.conf
#   ServerName www.ott.com
#   ServerAlias ott.com
#   ServerAdmin hariskido214@gmail.com
#   DocumentRoot /var/www/ott
echo -e "-------------\n-------------"
echo -e "Making Virtual Host file: 001-ott.conf /nin /etc/apache2/sites-available. You must manually update the info in this file"
echo -e "-------------\n-------------"
sleep 3
cd /etc/apache2/sites-available
sudo cp 000-default.conf 001-ott.conf

# Disable default virtual host 000-default.conf
echo -e "-------------\n-------------"
echo -e "Disablling 000-default.conf..."
echo -e "-------------\n-------------"
sleep 3
sudo a2dissite 000-default.conf

# Enable our virtual host 001-ott.conf
echo -e "-------------\n-------------"
echo -e "Enabelling 001-ott.conf..."
echo -e "-------------\n-------------"
sleep 3
sudo a2ensite 001-ott.conf

# Update /etc/hosts file with new site redirect on ip-localhost
echo -e "-------------\n-------------"
echo -e "Updating /etc/hosts..."
echo -e "-------------\n-------------"
sleep 3
sudo sed -i '1 a 127.0.0.1 www.ott.com' /etc/hosts

# Restart apache2.service
echo -e "-------------\n-------------"
echo -e "Restarting apache2.service ..."
echo -e "-------------\n-------------"
sleep 3
sudo systemctl restart apache2.service

# Install php
echo -e "-------------\n-------------"
echo -e "Installing php..."
echo -e "-------------\n-------------"
sleep 3
cd ~
sudo apt-get update
sudo apt-get install php

# Install php-mysql
echo -e "-------------\n-------------"
echo -e "Installing php-mysql..."
echo -e "-------------\n-------------"
sleep 3
sudo apt-get update
sudo apt-get install php-mysql

# Install git
# Remind user to update global variables
echo -e "-------------\n-------------"
echo -e "Installing git..."
echo -e "-------------\n-------------"
sleep 3
sudo apt-get update
sudo apt-get install git

echo -e "-------------\n-------------\nRemember to update global variables for git:\ngit config --global user.name 'YourUserName'\ngit config --global user.email 'YourGitEmail@email.com'\ncat .git/config"

# Last comment - Remind user to update 001-ott.conf and restart apache
echo -e "-------------\n-------------"
echo -e "Remember to update info in /etc/apache2/sites-available/001-ott.conf...\n Once complete, run following command once again: \nsudo systemctl restart apache2.service"
echo -e "-------------\n-------------"
sleep 3
