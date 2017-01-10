#!/bin/sh

# A simple script for remotely rebooting a Ubiquiti UniFi access point
# Version 1.0 (Dec 15, 2015)
# by Steve Jenkins (http://www.stevejenkins.com/)

# Requires sshpass (https://sourceforge.net/projects/sshpass/) which
# is probably available via dnf, yum, or apt on your *nix distro.

# USAGE
# Update the user-configurable settings below, then run ./uap-reboot.sh from
# the command line. To reboot on a schedule, create a cronjob such as:
# 45 3 * * * /usr/local/bin/uap-reboot.sh > /dev/null 2>&1 #Reboot UniFi AP
# The above example will reboot the UniFi access point every morning at 3:45 AM.

# USER-CONFIGURABLE SETTINGS
username=ubnt
password=ubnt
known_hosts_file=/dev/null
uap_ip=192.168.1.11

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE
echo "Rebooting UniFi access point at $uap_ip..."

if sshpass -p $password ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username@$uap_ip reboot; then
        echo "Reboot complete!" 1>&2
        exit 0
else
        echo "Could not reboot UniFi access point. Please check your settings." 1>&2
        exit 1
fi
